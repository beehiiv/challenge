import "@testing-library/jest-dom";
import App from "./App";
import { QueryParamProvider } from "use-query-params";

import { render, screen, waitFor, within } from "@testing-library/react";
import { getSubscribers, createSubscriber } from "./services/subscriber";
import { subscriberOne, subscriberTwo } from "./fixtures";
import userEvent from "@testing-library/user-event";

jest.mock("./services/subscriber");

const renderComponent = () => (
  <QueryParamProvider>
    <App />
  </QueryParamProvider>
);

describe("App", () => {
  beforeEach(() => {
    (getSubscribers as jest.Mock).mockResolvedValue({
      data: {
        subscribers: [subscriberOne, subscriberTwo],
        pagination: {
          page: 1,
          per_page: 1,
          total: 2,
          total_pages: 2,
        },
      },
    });
  });

  test("renders component", () => {
    render(renderComponent());
    expect(screen.getByTestId("appComponent")).toBeInTheDocument();
  });

  test("renders 'Add Subscriber' button", () => {
    render(renderComponent());
    expect(
      screen.getByTestId("addSubscriberButtonComponent")
    ).toBeInTheDocument();
  });

  test("renders subscribers count", () => {
    render(renderComponent());
    expect(screen.getByText("2 Subscribers")).toBeInTheDocument();
  });

  test("renders list of subscribers", async () => {
    render(renderComponent());
    await waitFor(() =>
      expect(screen.getByTestId("subscriberTableComponent")).toBeInTheDocument()
    );
  });

  test("renders pagination", async () => {
    render(renderComponent());

    expect(screen.getByTestId("tablePaginationComponent")).toBeInTheDocument();
    expect(screen.getAllByTestId("tablePaginationPageButton").length).toBe(2);
  });

  describe("interactions", () => {
    test("clicking on 'Add Subscriber' should render add subscriber form", async () => {
      render(renderComponent());

      const button = screen.getByTestId("addSubscriberButtonComponent");

      await userEvent.click(button);

      expect(
        screen.getByTestId("addSubscriberFormComponent")
      ).toBeInTheDocument();
    });

    test("adding a new subscriber should refresh the subscriber list", async () => {
      (createSubscriber as jest.Mock).mockResolvedValue({
        data: {
          ...subscriberOne,
          id: 789,
          email: "foo@bar.baz",
          name: "",
        },
      });

      render(renderComponent());

      const button = screen.getByTestId("addSubscriberButtonComponent");

      await userEvent.click(button);

      const form = screen.getByTestId("addSubscriberFormComponent");
      const emailField = within(form).getByRole("textbox", { name: "email" });
      const submitButton = screen.getByTestId(
        "addSubscriberFormComponent-submitButton"
      );

      await userEvent.type(emailField, "foo@bar.baz");
      await userEvent.click(submitButton);

      await waitFor(() => expect(createSubscriber).toHaveBeenCalled());
      await waitFor(() => expect(getSubscribers).toHaveBeenCalled());
    });

    test("clicking on next page should load the next page", async () => {
      render(renderComponent());

      await waitFor(() =>
        expect(screen.getAllByTestId("tablePaginationPageButton").length).toBe(
          2
        )
      );

      const secondPageButton = screen.getByRole("button", {
        name: "2",
      });

      await userEvent.click(secondPageButton);

      expect(window.location.href.includes("page=2")).toBe(true);
    });
  });
});
