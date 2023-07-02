import { makeAutoObservable } from "mobx";
import type { Subscriber } from "../global";
import { getSubscribers } from "../services/subscriber";

export class Subscribers {
  items: Subscriber[] = [];

  constructor() {
    makeAutoObservable(this);
  }

  setItems = (items: Subscriber[]) => {
    this.items = items;
  };

  fetch = async () => {
    const response = await getSubscribers();
    this.setItems(response.data.items);
  };
}
