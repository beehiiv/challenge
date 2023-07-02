import { useState } from "react";
import Modal, { ModalBody, ModalFooter } from "../Modal";
import Button, { SecondaryButton } from "../Button";
import store from "../../store";
import { SubscriberStatus } from "../../global.d";

export interface Props {
  isOpen: boolean;
  onClose(): void;
  onSuccess(): void;
  subscriberId: number;
  status: SubscriberStatus;
}

const SubscriberStatusModal = (props: Props) => {
  const { isOpen, onSuccess, onClose, subscriberId, status } = props;
  const [isDeleting, setIsDeleting] = useState(false);

  const onUpdate = async () => {
    const newStatus: SubscriberStatus =
      status === SubscriberStatus.Active
        ? SubscriberStatus.Inactive
        : SubscriberStatus.Active;

    setIsDeleting(true);
    try {
      await store.subscribers.updateItemStatus(subscriberId, newStatus);
      onSuccess();
    } catch (error) {
      // handle error
    }
    setIsDeleting(false);
  };

  const modalTitleText = status === "active" ? "Unsubscribe" : "Resubscribe";
  const messageBodyText =
    status === "active"
      ? "Are you sure you'd like to unsubscribe this subscriber?"
      : "Are you sure you'd like to resubscribe this subscriber?";
  const buttonText = status === "active" ? "Unsubscribe" : "Resubscribe";

  return (
    <Modal
      modalTitle={modalTitleText}
      showModal={isOpen}
      onCloseModal={onClose}
    >
      <>
        <ModalBody>{messageBodyText}</ModalBody>
        <ModalFooter>
          <SecondaryButton
            className="mx-2"
            onClick={onClose}
            loading={undefined}
            disabled={undefined}
          >
            Cancel
          </SecondaryButton>
          <Button
            type="primary"
            loading={isDeleting}
            onClick={onUpdate}
            className={undefined}
            disabled={undefined}
          >
            {buttonText}
          </Button>
        </ModalFooter>
      </>
    </Modal>
  );
};

export default SubscriberStatusModal;
