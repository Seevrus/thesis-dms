import { Form } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

interface EmailCodeProps {
  emailCode: string;
  setEmailCode: React.Dispatch<React.SetStateAction<string>>;
  emailCodeError: string;
}

const EmailCode = ({
  emailCode,
  setEmailCode,
  emailCodeError,
}: EmailCodeProps) => {
  const onEmailCodeChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setEmailCode(e.target.value);
  };

  return (
    <Form.Group className="mb-3" controlId={`code-${uuidv4()}`}>
      <Form.Label>Email kód</Form.Label>
      <Form.Control
        isInvalid={!!emailCodeError}
        onInput={onEmailCodeChange}
        required
        value={emailCode}
      />
      <Form.Control.Feedback type="invalid">{emailCodeError}</Form.Control.Feedback>
    </Form.Group>
  );
};

export default EmailCode;
