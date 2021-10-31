import { Button, Form, InputGroup } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

interface PasswordProps {
  label?: string;
  password: string;
  setPassword: React.Dispatch<React.SetStateAction<string>>;
  showRequirements: boolean;
  requireValidation: boolean;
  negativeFeedback?: boolean;
  passwordError?: string;
  positiveFeedback?: boolean;
  passwordSuccess?: string;
  updatable?: boolean;
  updatePassword?: () => void;
}

const Password = ({
  label = 'Jelszó',
  password,
  setPassword,
  showRequirements,
  requireValidation,
  negativeFeedback = false,
  passwordError = '',
  positiveFeedback = false,
  passwordSuccess = '',
  updatable = false,
  updatePassword,
}: PasswordProps) => {
  const onPasswordChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const loginPwdInput = e.target.value;
    setPassword(loginPwdInput);
  };

  return (
    <Form.Group controlId={`password-${uuidv4()}`}>
      <Form.Label>
        {label}
        {showRequirements && (
        <ul>
          <li>Minimum 8 karakter</li>
          <li>Minimum 1 kisbetű</li>
          <li>Minimum 1 nagybetű</li>
          <li>Minimum 1 számjegy</li>
        </ul>
        )}
      </Form.Label>
      <InputGroup className="mb-3">
        <Form.Control
          isInvalid={requireValidation && !!passwordError}
          isValid={requireValidation && !!passwordSuccess}
          onChange={onPasswordChange}
          required
          type="password"
          value={password}
        />
        {updatable && (
          <Button
            id={`passwordUpdateButton-${uuidv4()}`}
            onClick={updatePassword}
            variant="primary"
          >
            Mentés
          </Button>
        )}
        {negativeFeedback && (
        <Form.Control.Feedback type="invalid">
          {passwordError}
        </Form.Control.Feedback>
        )}
        {positiveFeedback && (
        <Form.Control.Feedback type="valid">
          {passwordSuccess}
        </Form.Control.Feedback>
        )}
      </InputGroup>
    </Form.Group>
  );
};

export default Password;
