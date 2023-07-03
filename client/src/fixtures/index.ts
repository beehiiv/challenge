import { Subscriber, SubscriberStatus } from "../global.d";

export const subscriberOne: Subscriber = {
  id: 123,
  name: "fake-name-123",
  email: "fake-name-123@foo.bar",
  status: SubscriberStatus.Inactive,
  created_at: "",
  updated_at: "",
};

export const subscriberTwo: Subscriber = {
  id: 456,
  name: "fake-name-456",
  email: "fake-name-456@foo.bar",
  status: SubscriberStatus.Active,
  created_at: "",
  updated_at: "",
};
