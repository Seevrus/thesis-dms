import { BaseResponseT } from './commonTypes';
import { EmailStatusEnum, UserPermissionsEnum, UserStatusEnum } from './userSliceTypes';

interface CompanyWithIdT {
  id: number;
  companyName: string;
}

export interface OtherUserT {
  taxNumber: number;
  companyName: string;
  userRealName: string;
  userStatus: `${UserStatusEnum}`;
  userEmail: string;
  emailStatus: `${EmailStatusEnum}`;
  lockedOut: boolean;
  userPermissions: `${UserPermissionsEnum}`[];
}

export interface OtherUsersSliceT {
  companies: CompanyWithIdT[];
  searchResults: OtherUserT[];
  selectedUser: OtherUserT;
}

export interface FetchCompaniesResponseT extends BaseResponseT {
  companies: CompanyWithIdT[];
}

export type SearchUserRequestT = string | number;

export interface SearchUserResponseT extends BaseResponseT {
  users: OtherUserT[];
}
