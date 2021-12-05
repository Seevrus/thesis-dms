import { BaseResponseT } from '../commonTypes';
import { EmailStatusEnum, UserPermissionsEnum, UserStatusEnum } from '../user/userSliceTypes';

export enum UserSearchTypeEnum {
  ALL = 'ALL',
  LAST_LOGIN = 'LAST_LOGIN',
}

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

export type SearchUserRequestT = {
  keyword: string | number;
  searchType: UserSearchTypeEnum.ALL;
};

export interface SearchUserResponseT extends BaseResponseT {
  users: OtherUserT[];
}
