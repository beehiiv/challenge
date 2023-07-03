import { useState } from "react";
import Modal, { ModalBody, ModalFooter } from "../Modal";
import Button, { SecondaryButton } from "../Button";
import store from "../../store";
import { SubscriberStatus } from "../../global.d";
import FormError from "../FormError";

export interface Props {
  isOpen: boolean;
  onClose(): void;
  onSuccess(): void;
  subscriberId: number;
  status: SubscriberStatus;
}

const SubscriberStatusModal = ({
  isOpen,
  onSuccess,
  onClose,
  subscriberId,
  status,
}: Props) => {
  const [error, setError] = useState<string | null>(null);
  const [isUpdating, setIsUpdating] = useState(false);

  const onUpdate = async () => {
    setError(null);

    const newStatus: SubscriberStatus =
      status === SubscriberStatus.Active
        ? SubscriberStatus.Inactive
        : SubscriberStatus.Active;

    setIsUpdating(true);
    try {
      await store.subscribers.updateItemStatus(
        subscriberId,
        SubscriberStatus.Foo
      );
      onSuccess();
    } catch (error: any) {
      if (!error?.response?.data) {
        return;
      }

      setError(
        error.response.data?.errors?.unknown || error.response.data?.message
      );
    }
    setIsUpdating(false);
  };

  const modalTitleText = status === "active" ? "Unsubscribe" : "Resubscribe";
  const messageBodyText =
    status === "active"
      ? "Are you sure you'd like to unsubscribe this subscriber?"
      : "Are you sure you'd like to resubscribe this subscriber?";
  const buttonText = status === "active" ? "Unsubscribe" : "Resubscribe";

  const handleClose = () => {
    setError(null);
    setIsUpdating(false);
    onClose();
  };

  return (
    <Modal
      modalTitle={modalTitleText}
      showModal={isOpen}
      onCloseModal={handleClose}
    >
      <>
        <ModalBody>
          <div className="text-left">
            {error && <FormError message={error} />}
            <p className="py-2">{messageBodyText}</p>
          </div>
        </ModalBody>
        <ModalFooter>
          <SecondaryButton
            className="mx-2"
            onClick={handleClose}
            loading={undefined}
            disabled={undefined}
          >
            Cancel
          </SecondaryButton>
          <Button
            type="primary"
            loading={isUpdating}
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
