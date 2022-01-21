import { useState } from "react";
import Modal, { ModalBody, ModalFooter } from '../Modal'
import PropTypes from 'prop-types';

// Components
import Button, { SecondaryButton } from '../Button';

// Services
import { updateSubscriber } from "../../services/subscriber";

const SubscriberStatusModal = (props) => {
  const { isOpen, onSuccess, onClose, onError, subscriberId, status } = props;
  const [isDeleting, setIsDeleting] = useState(false)
  const [errorText, setErrorText] = useState('')
  const [errorClass, setErrorClass] = useState('')

  const onUpdate = () => {
    const payload = {
      status: status === 'active' ? 'inactive' : 'active'
    }

    setIsDeleting(true)
    updateSubscriber(subscriberId, payload)
    .then(() => {
      onSuccess()
    })
    .catch((payload) => {
      const error = payload?.response?.data?.message || 'Something went wrong'
      setErrorText(error)
      setErrorClass("error")
      onError()
    })
    .finally(() => {
      setIsDeleting(false)
    })
  }

  const modalTitleText = status === 'active' ? 
    "Unsubscribe" : "Resubscribe"
  const messageBodyText = status === 'active' ? 
    "Are you sure you'd like to unsubscribe this subscriber?" :
    "Are you sure you'd like to resubscribe this subscriber?"
  const buttonText = status === 'active' ? 
    "Unsubscribe" : "Resubscribe"

  return (
    <Modal modalTitle={modalTitleText} showModal={isOpen} onCloseModal={onClose}>
      <>
        <div className="error">
          {errorText}
        </div>
        <ModalBody>
          {messageBodyText}
        </ModalBody>
        <ModalFooter>
          <SecondaryButton
            className="mx-2"
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
  onError: PropTypes.func,
  subscriberId: PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  status: PropTypes.string
}

export default SubscriberStatusModal;
