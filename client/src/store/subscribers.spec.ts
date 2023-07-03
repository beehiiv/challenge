import { subscriberOne } from "../fixtures";
import { Subscribers } from "./subscribers";
import {
  createSubscriber,
  getSubscribers,
  updateSubscriber,
} from "../services/subscriber";
import { SubscriberStatus } from "../global.d";

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

  describe("addItem", () => {
    beforeEach(() => {
      subscribers.items = [subscriberOne];
    });

    afterEach(() => {
      subscribers.items = [];
    });

    test("should set an item at the beginning of the items", async () => {
      (createSubscriber as jest.Mock).mockImplementationOnce(() =>
        Promise.resolve({
          data: {
            ...subscriberOne,
            id: 678,
            email: "foo@bar.baz",
            name: "foo",
          },
        })
      );

      await subscribers.addItem("foo", "foo@bar.baz");
      expect(subscribers.items.length).toBe(2);
      expect(subscribers.items[0].id).toBe(678);
    });
  });

  describe("setItems", () => {
    test("should set items", () => {
      subscribers.setItems([subscriberOne]);
      expect(subscribers.items.length).toBe(1);
    });
  });

  describe("setPagination", () => {
    test("should set pagination", () => {
      subscribers.setPagination({
        page: 1,
        per_page: 10,
        total: 100,
        total_pages: 10,
      });
      expect(subscribers.pagination).toStrictEqual({
        page: 1,
        per_page: 10,
        total: 100,
        total_pages: 10,
      });
    });
  });

  describe("updateItemStatus", () => {
    beforeEach(() => {
      subscribers.items = [subscriberOne];
    });

    afterEach(() => {
      subscribers.items = [];
    });

    describe("on success", () => {
      test("should update item's status", async () => {
        (updateSubscriber as jest.Mock).mockImplementationOnce(() =>
          Promise.resolve({
            data: {
              ...subscriberOne,
              status: SubscriberStatus.Active,
            },
          })
        );

        await subscribers.updateItemStatus(
          subscriberOne.id,
          SubscriberStatus.Active
        );
        expect(subscribers.items[0].status).toBe(SubscriberStatus.Active);
      });
    });

    describe("on error", () => {
      test("should update item's status", async () => {
        (updateSubscriber as jest.Mock).mockImplementationOnce(() =>
          Promise.reject(new Error("Something went wrong!"))
        );

        await expect(
          subscribers.updateItemStatus(
            subscriberOne.id,
            SubscriberStatus.Active
          )
        ).rejects.toThrow("Something went wrong!");
      });
    });
  });

  describe("fetch", () => {
    describe("on success", () => {
      test("should set items", async () => {
        (getSubscribers as jest.Mock).mockImplementationOnce(() =>
          Promise.resolve({
            data: {
              subscribers: [subscriberOne],
              pagination: {
                page: 1,
                per_page: 25,
                total: 25,
                total_pages: 1,
              },
            },
          })
        );

        await subscribers.fetch({
          page: 1,
          perPage: 20,
        });

        expect(JSON.stringify(subscribers.items)).toBe(
          JSON.stringify([subscriberOne])
        );
      });

      test("should set pagination", async () => {
        (getSubscribers as jest.Mock).mockImplementationOnce(() =>
          Promise.resolve({
            data: {
              subscribers: [subscriberOne],
              pagination: {
                page: 1,
                per_page: 25,
                total: 25,
                total_pages: 1,
              },
            },
          })
        );

        await subscribers.fetch({
          page: 1,
          perPage: 25,
        });

        expect(JSON.stringify(subscribers.pagination)).toBe(
          JSON.stringify({
            page: 1,
            per_page: 25,
            total: 25,
            total_pages: 1,
          })
        );
      });
    });

    describe("on error", () => {
      test("should not set items", async () => {
        (getSubscribers as jest.Mock).mockImplementationOnce(() =>
          Promise.reject(new Error("Something went wrong!"))
        );

        await expect(
          subscribers.fetch({
            page: 1,
            perPage: 20,
          })
        ).rejects.toThrow("Something went wrong!");
        expect(subscribers.items.length).toBe(0);
      });

      test("should not set pagination", async () => {
        (getSubscribers as jest.Mock).mockImplementationOnce(() =>
          Promise.reject(new Error("Something went wrong!"))
        );

        await expect(
          subscribers.fetch({
            page: 1,
            perPage: 20,
          })
        ).rejects.toThrow("Something went wrong!");
        expect(subscribers.pagination).toBe(null);
      });
    });
  });
});
