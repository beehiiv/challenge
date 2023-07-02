import "@testing-library/jest-dom";
import App from "./App";
import { QueryParamProvider } from "use-query-params";

import { render, screen } from "@testing-library/react";
import { getSubscribers } from "./services/subscriber";

jest.mock("./services/subscriber");

const renderComponent = () => (
  <QueryParamProvider>
    <App />
  </QueryParamProvider>
);

describe("App", () => {
  beforeEach(() => {
    (getSubscribers as jest.Mock).mockResolvedValue([]);
  });

  test("renders component", () => {
    render(renderComponent());
    expect(screen.getByTestId("appComponent")).toBeInTheDocument();
  });

  describe("interactions", () => {});
});
