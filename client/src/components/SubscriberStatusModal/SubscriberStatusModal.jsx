import { useState } from "react";
import Modal, { ModalBody, ModalFooter } from '../Modal'
import PropTypes from 'prop-types';

// Components
import Button, { SecondaryButton } from '../Button';

// Services
import { updateSubscriber } from "../../services/subscriber";

const SubscriberStatusModal = (props) => {
  const { isOpen, onSuccess, onClose, subscriberId, status } = props;
  const [isDeleting, setIsDeleting] = useState(false)

  const onUpdate = () => {
    var payload
    if (status === 'active') {
      payload = {status: 'inactive'}
    } else {
            payload = {status: 'active'}
    }

    setIsDeleting(true)
    updateSubscriber(subscriberId, payload)
    .then(() => {
      onSuccess()
    })
    .catch((payload) => {
      const error = payload.toString()
      console.error(error)
    })
    .finally(() => {
      setIsDeleting(false)
    })
  }

  var modalTitleText = ""
  var messageBodyText = ""
  var buttonText = ""

  if (status === 'active') {
    modalTitleText = "Unsubscribe"
    messageBodyText = "Are you sure you'd like to unsubscribe?"
  } else {
    modalTitleText = "Resubscribe"
    messageBodyText = "Are you sure you'd like to resubscribe?"
  }

  buttonText = modalTitleText

  return (
    <Modal modalTitle={modalTitleText} showModal={isOpen} onCloseModal={onClose}>
      <>
        <ModalBody>
          {messageBodyText}
        </ModalBody>
        <ModalFooter>
          <SecondaryButton
            className="cancel_btn"
            onClick={onClose}
          >
            Cancel
          </SecondaryButton>
          <Button
            type="primary"
            loading={isDeleting}
            onClick={onUpdate}
          >
            {buttonText}
          </Button>
        </ModalFooter>
      </>
    </Modal>
  );
};

SubscriberStatusModal.propTypes = {
  isOpen: PropTypes.bool,
  onClose: PropTypes.func,
  onSuccess: PropTypes.func,
  subscriberId: PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  status: PropTypes.string
}

export default SubscriberStatusModal;
