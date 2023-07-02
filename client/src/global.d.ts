export enum SubscriberStatus {
  Inactive = "inactive",
  Active = "active",
}

export type Subscriber = {
  id: number;
  name: string;
  email: string;
  status: SubscriberStatus;
  created_at: string;
  updated_at: string;
};
