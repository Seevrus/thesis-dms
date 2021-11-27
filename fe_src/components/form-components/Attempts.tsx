import * as React from 'react';
import {
  Col,
  Form,
  InputGroup,
  Row,
} from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

interface AttemptsProps {
  lockedOut: boolean;
  unlockUserST: boolean
  setUnlockUserST: React.Dispatch<React.SetStateAction<boolean>>;
}

const UserPermissions = ({
  lockedOut,
  unlockUserST,
  setUnlockUserST,
}: AttemptsProps) => {
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setUnlockUserST(e.target.checked);
  };

  return (
    <Row>
      <Col className="md-12">
        <Form.Group controlId={`inline-unlock-user-${uuidv4()}`}>
          <Form.Label>{lockedOut ? 'Zárolás feloldása' : 'Felhasználó nincs zárolva.'}</Form.Label>
          {lockedOut
            && (
              <InputGroup className="mb-3">
                <Form.Check
                  inline
                  id="unlock-user"
                  label="Felhasználó zárolásának feloldása"
                  name="user-permission"
                  type="checkbox"
                  checked={unlockUserST}
                  onChange={handleChange}
                />
              </InputGroup>
            )}
        </Form.Group>
      </Col>
    </Row>
  );
};

export default UserPermissions;
