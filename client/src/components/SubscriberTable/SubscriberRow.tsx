import StatusPill from "../StatusPill";
import { Subscriber } from "../../global.d";
import { useState } from "react";
import SubscriberStatusModal from "../SubscriberStatusModal";

export interface Props {
  subscriber: Subscriber;
}

const SubscriberRow = ({ subscriber }: Props) => {
  const [isModalOpen, setIsModalOpen] = useState(false);

  const onStatusClick = () => setIsModalOpen(true);
  const onModalClose = () => setIsModalOpen(false);
  const onSubscriberUpdateSuccess = () => {
    setIsModalOpen(false);
  };

  return (
    <tr>
      <td className="px-6 py-4 whitespace-nowrap">
        <div className="text-sm text-gray-900">{subscriber.name}</div>
      </td>
      <td className="px-6 py-4 whitespace-nowrap">
        <div className="text-sm text-gray-900">{subscriber.email}</div>
      </td>
      <td className="px-6 py-4 whitespace-nowrap">
        <StatusPill value={subscriber.status} />
      </td>
      <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
        <button
          className="text-primary-gold-600 hover:text-primary-gold-900 underline"
          onClick={onStatusClick}
        >
          {subscriber.status === "active" ? "Unsubscribe" : "Subscribe"}
        </button>
        <SubscriberStatusModal
          isOpen={isModalOpen}
          onClose={onModalClose}
          onSuccess={onSubscriberUpdateSuccess}
          subscriberId={subscriber.id}
          status={subscriber.status}
        />
      </td>
    </tr>
  );
};

export default SubscriberRow;
