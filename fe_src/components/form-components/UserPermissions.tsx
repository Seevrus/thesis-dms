import * as React from 'react';
import { Form, InputGroup } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

import { UserPermissionsEnum } from '../../store/userSliceTypes';

interface UserPermissionsProps {
  userPermissionsST: `${UserPermissionsEnum}`[];
  setUserPermissionsST: React.Dispatch<React.SetStateAction<`${UserPermissionsEnum}`[]>>;
}

const UserPermissions = ({
  userPermissionsST,
  setUserPermissionsST,
}: UserPermissionsProps) => {
  const userPermissionsTranslate = {
    [UserPermissionsEnum.ACTIVITY_ADMINISTRATOR]: 'Felhasználói aktivitás',
    [UserPermissionsEnum.INACTIVE]: 'Inaktív',
    [UserPermissionsEnum.REGULAR]: 'Munkavállaló',
    [UserPermissionsEnum.USER_ADMINISTRATOR]: 'Felhasználók kezelése',
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const permission = e.target.id as `${UserPermissionsEnum}`;
    const permissionSwitch = e.target.checked;
    if (permission === UserPermissionsEnum.INACTIVE) {
      if (permissionSwitch) {
        setUserPermissionsST([UserPermissionsEnum.INACTIVE]);
      } else {
        setUserPermissionsST([UserPermissionsEnum.REGULAR]);
      }
    } else if (permissionSwitch) {
      setUserPermissionsST(
        [
          ...(userPermissionsST.filter((p) => p !== UserPermissionsEnum.INACTIVE)),
          permission,
        ],
      );
    } else {
      setUserPermissionsST(userPermissionsST.filter((p) => p !== permission));
    }
  };

  return (
    <Form.Group controlId={`inline-email-status-${uuidv4()}`}>
      <Form.Label>Jogosultságok</Form.Label>
      <InputGroup className="mb-3">
        {Object.keys(UserPermissionsEnum).map(
          (userPermission: `${UserPermissionsEnum}`) => (
            userPermission !== UserPermissionsEnum.DOCUMENT_CREATOR && (
            <Form.Check
              inline
              id={userPermission}
              key={`inline-email-status-${userPermission}`}
              label={userPermissionsTranslate[userPermission]}
              name="user-permission"
              type="checkbox"
              checked={userPermissionsST.includes(userPermission)}
              onChange={handleChange}
            />
            )
          ),
        )}
      </InputGroup>
    </Form.Group>
  );
};

export default UserPermissions;
