import { Form } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

interface UserRealNameProps {
  disabled?: boolean;
  userRealName: string;
  setUserRealName?: React.Dispatch<React.SetStateAction<string>>;
}

const UserRealName = ({
  disabled = true,
  userRealName,
  setUserRealName,
}: UserRealNameProps) => {
  const onNameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setUserRealName(e.target.value);
  };

  return (
    <Form.Group className="mb-3" controlId={`userRealName-${uuidv4()}`}>
      <Form.Label>Név</Form.Label>
      <Form.Control
        disabled={disabled}
        onInput={onNameChange}
        value={userRealName}
      />
    </Form.Group>
  );
};

export default UserRealName;
