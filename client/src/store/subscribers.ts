import { makeAutoObservable } from "mobx";
import type { Subscriber, Pagination, SubscriberStatus } from "../global";
import {
  createSubscriber,
  getSubscribers,
  updateSubscriber,
} from "../services/subscriber";

export class Subscribers {
  items: Subscriber[] = [];
  pagination: Pagination | null = null;

  constructor() {
    makeAutoObservable(this);
  }

  addItem = async (name: string, email: string) => {
    const response = await createSubscriber({
      name,
      email,
    });

    this.items.splice(0, 0, response.data);
  };

  updateItemStatus = async (itemId: number, status: SubscriberStatus) => {
    const response = await updateSubscriber(itemId, {
      status,
    });

    // TODO: Complexity is O(n)
    // Should use an Object here with ids mapped as keys
    // To reduce the complexity to O(1)
    this.items = [
      ...this.items.map((item) => (item.id === itemId ? response.data : item)),
    ];
  };

  setItems = (items: Subscriber[]) => {
    this.items = items;
  };

  setPagination = (pagination: Pagination) => {
    this.pagination = pagination;
  };

  fetch = async (params: { page: number; perPage: number }) => {
    const response = await getSubscribers({
      page: params.page,
      per_page: params.perPage,
    });
    this.setItems(response.data.subscribers);
    this.setPagination(response.data.pagination);
  };
}
