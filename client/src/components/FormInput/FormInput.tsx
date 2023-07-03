export interface Props {
  type: string;
  name: string;
  placeholder: string;
  value: string;
  onChange(event: React.ChangeEvent<HTMLInputElement>): void;
  errorMessage?: string | null;
}

const FormInput = ({
  value,
  onChange,
  errorMessage,
  type,
  name,
  placeholder,
}: Props) => {
  const classNames: string[] = [];
  if (errorMessage) {
    classNames.push("border-red-500");
  }

  return (
    <>
      <input
        className={`shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline ${classNames.join(
          " "
        )}`}
        name={name}
        type={type}
        placeholder={placeholder}
        onChange={onChange}
        value={value}
        aria-label={name}
      />
      {errorMessage && (
        <p className="text-red-500 text-xs italic">{errorMessage}</p>
      )}
    </>
  );
};

export default FormInput;
