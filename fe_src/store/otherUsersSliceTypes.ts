import { BaseResponseT } from './commonTypes';
import { EmailStatusEnum, UserPermissionsEnum } from './userSliceTypes';

export interface OtherUserT {
  taxNumber: number;
  companyName: string;
  userRealName: string;
  userPermissions: `${UserPermissionsEnum}`[];
  userEmail: string;
  emailStatus: `${EmailStatusEnum}`;
}

export interface OtherUsersSliceT {
  searchResults: OtherUserT[];
  selectedUser: OtherUserT;
}

export type SearchUserRequestT = string | number;

export interface SearchUserResponseT extends BaseResponseT {
  users: OtherUserT[];
}
