import { subscriberOne } from "../fixtures";
import { Subscribers } from "./subscribers";
import { getSubscribers } from "../services/subscriber";

jest.mock("../services/subscriber");

describe("Subscribers Store", () => {
  beforeAll(() => {
    (getSubscribers as jest.Mock).mockResolvedValue([]);
  });

  let subscribers: InstanceType<typeof Subscribers>;
  beforeEach(() => {
    subscribers = new Subscribers();
  });

  describe("constructor", () => {
    test("should have empty items", () => {
      expect(subscribers.items.length).toBe(0);
    });
  });

  describe("setItems", () => {
    test("should set items", () => {
      subscribers.setItems([subscriberOne]);
      expect(subscribers.items.length).toBe(1);
    });
  });

  describe("fetch", () => {
    // const getMock = jest.fn();

    // beforeEach(() => {
    //   getSubscribers;
    // });

    // afterEach(() => {
    //   getMock.mockRestore();
    // });

    describe("on success", () => {
      test("should set items", async () => {
        (getSubscribers as jest.Mock).mockImplementationOnce(() =>
          Promise.resolve({
            data: {
              items: [subscriberOne],
            },
          })
        );

        await subscribers.fetch();

        expect(JSON.stringify(subscribers.items)).toBe(
          JSON.stringify([subscriberOne])
        );
      });
    });

    describe("on error", () => {
      test("should not set items", async () => {
        (getSubscribers as jest.Mock).mockImplementationOnce(() =>
          Promise.reject(new Error("Something went wrong!"))
        );

        await expect(subscribers.fetch()).rejects.toThrow(
          "Something went wrong!"
        );
        expect(subscribers.items.length).toBe(0);
      });
    });
  });
});
