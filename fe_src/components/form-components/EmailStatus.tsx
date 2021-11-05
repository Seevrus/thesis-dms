import * as React from 'react';
import { Form, InputGroup } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

import { EmailStatusEnum } from '../../store/userSliceTypes';

interface EmailStatusProps {
  emailStatusST: `${EmailStatusEnum}`;
  setEmailStatusST: React.Dispatch<React.SetStateAction<`${EmailStatusEnum}`>>;
}

const EmailStatus = ({
  emailStatusST,
  setEmailStatusST,
}: EmailStatusProps) => {
  const emailStatusTranslate = {
    [EmailStatusEnum.NOT_VALIDATED]: 'Nincs érvényesítve',
    [EmailStatusEnum.NO_EMAIL]: 'Nincs megadva',
    [EmailStatusEnum.VALID_EMAIL]: 'Érvényes',
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setEmailStatusST(e.target.id as `${EmailStatusEnum}`);
  };

  return (
    <Form.Group controlId={`inline-email-status-${uuidv4()}`}>
      <Form.Label>Email státusz</Form.Label>
      <InputGroup className="mb-3">
        {Object.keys(EmailStatusEnum).map((emailStatus: `${EmailStatusEnum}`) => (
          <Form.Check
            inline
            id={emailStatus}
            key={`inline-email-status-${emailStatus}`}
            label={emailStatusTranslate[emailStatus]}
            name="email-status"
            type="radio"
            checked={emailStatus === emailStatusST}
            onChange={handleChange}
          />
        ))}
      </InputGroup>
    </Form.Group>
  );
};

export default EmailStatus;
