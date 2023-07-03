import { useState } from "react";
import Button, { SecondaryButton } from "../Button";
import Modal, { ModalBody, ModalFooter } from "../Modal";
import store from "../../store";
import FormInput from "../FormInput";
import FormError from "../FormError";

export interface Props {
  isOpen: boolean;
  onClose(): void;
  onSuccess(): void;
}

const AddSubscriberModal = ({ isOpen, onClose, onSuccess }: Props) => {
  const [errors, setErrors] = useState<{
    email?: string;
    name?: string;
    unknown?: string;
  } | null>(null);
  const [isSaving, setIsSaving] = useState(false);
  const [email, setEmail] = useState("");
  const [name, setName] = useState("");

  const handleChange: React.ChangeEventHandler<HTMLInputElement> = (e) => {
    const {
      target: { name, value },
    } = e;

    if (name === "email") {
      setEmail(value);
    } else if (name === "name") {
      setName(value);
    }
  };

  const onSubmit = async () => {
    if (isSaving) {
      return;
    }

    setIsSaving(true);

    // Clear errors
    setErrors(null);

    try {
      await store.subscribers.addItem(name, email);

      // Clear form
      setName("");
      setEmail("");

      onSuccess();
    } catch (error: any) {
      if (!error?.response?.data?.errors) {
        setErrors({
          ...errors,
          unknown: "Something went wrong, please try again",
        });
        return;
      }

      if (error?.response?.data?.errors?.email) {
        setErrors({
          ...errors,
          email: error?.response?.data?.errors?.email.join("\n"),
        });
      }

      if (error?.response?.data?.errors?.name) {
        setErrors({
          ...errors,
          name: error?.response?.data?.errors?.name.join("\n"),
        });
      }
    }

    setIsSaving(false);
  };

  const handleClose = () => {
    setErrors(null);
    setName("");
    setEmail("");
    setIsSaving(false);
    onClose();
  };

  return (
    <Modal
      modalTitle="Add Subscriber"
      showModal={isOpen}
      onCloseModal={handleClose}
      data-testid="addSubscriberModalComponent"
    >
      <>
        <ModalBody>
          {errors?.unknown && <FormError message={errors.unknown} />}
          <form className="my-4 text-blueGray-500 text-lg leading-relaxed">
            <div className="mb-4">
              <label
                className="block text-gray-700 text-sm font-bold mb-2"
                htmlFor="email"
              >
                Email*
              </label>
              <FormInput
                name="email"
                type="email"
                placeholder="rickc137@citadel.com"
                onChange={handleChange}
                value={email}
                errorMessage={errors?.email}
              />
            </div>
            <div className="mb-4">
              <label
                className="block text-gray-700 text-sm font-bold mb-2"
                htmlFor="name"
              >
                Name
              </label>
              <FormInput
                name="name"
                type="text"
                placeholder="Rick Sanchez"
                onChange={handleChange}
                value={name}
                errorMessage={errors?.name}
              />
            </div>
          </form>
        </ModalBody>
        <ModalFooter>
          <SecondaryButton
            className="background-transparent font-bold uppercase px-6 py-2 text-sm outline-none focus:outline-none mr-1"
            type="button"
            onClick={handleClose}
            loading={undefined}
            disabled={undefined}
          >
            Cancel
          </SecondaryButton>
          <Button
            className="bg-blue-500 hover:bg-blue-700 text-white font-bold uppercase"
            type="button"
            onClick={onSubmit}
            loading={isSaving}
            disabled={undefined}
          >
            Add Subscriber
          </Button>
        </ModalFooter>
      </>
    </Modal>
  );
};

export default AddSubscriberModal;
