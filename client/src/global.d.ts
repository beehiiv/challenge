export enum SubscriberStatus {
  Inactive = "inactive",
  Active = "active",
  Foo = "foo",
}

export type Subscriber = {
  id: number;
  name: string;
  email: string;
  status: SubscriberStatus;
  created_at: string;
  updated_at: string;
};

export type Pagination = {
  page: number;
  per_page: number;
  total: number;
  total_pages: number;
};
