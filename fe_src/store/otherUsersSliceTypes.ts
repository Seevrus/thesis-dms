import { BaseResponseT } from './commonTypes';
import { EmailStatusEnum, UserPermissionsEnum } from './userSliceTypes';

interface CompanyWithIdT {
  id: number;
  companyName: string;
}

export interface OtherUserT {
  taxNumber: number;
  companyName: string;
  userRealName: string;
  userStatus: number;
  userEmail: string;
  emailStatus: `${EmailStatusEnum}`;
  loginAttempts: number;
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
