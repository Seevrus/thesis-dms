import { BaseResponseT } from './commonTypes';
import { EmailStatusEnum, UserPermissionsEnum } from './usersSliceTypes';

export interface OtherUserT {
  taxNumber: number;
  companyName: string;
  userRealName: string;
  userPermissions: `${UserPermissionsEnum}`[];
  userEmail: string;
  emailStatus: `${EmailStatusEnum}`;
}

export type SearchUserRequestT = string | number;

export interface SearchUserResponseT extends BaseResponseT {
  users: OtherUserT[];
}
