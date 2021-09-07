import { BaseResponseT, OutcomeT } from './commonTypes';

export enum UserPermissionsEnum {
  INACTIVE = 'INACTIVE',
  USER = 'USER',
  ACTIVITY_ADMINISTRATOR = 'ACTIVITY_ADMINISTRATOR',
  USER_ADMINISTRATOR = 'USER_ADMINISTRATOR',
  DOCUMENT_CREATOR = 'DOCUMENT_CREATOR',
}

interface UserPermissionsType {
  [key: number]: `${UserPermissionsEnum}`[];
}

export enum EmailStatusEnum {
  NO_EMAIL = 'NO_EMAIL',
  NOT_VALIDATED = 'NOT_VALIDATED',
  VALID_EMAIL = 'VALID_EMAIL',
}

export enum LoginStatusEnum {
  NOT_LOGGED_IN = 'NOT_LOGGED_IN',
  LOGGED_IN = 'LOGGED_IN',
}

export interface CompleteRegistrationRequestT {
  email: string;
  password: string;
}

export interface CompleteRegistrationresponseT extends BaseResponseT {
  emailStatus?: `${EmailStatusEnum}`;
}

export interface LoginRequestT {
  taxNumber: string;
  password: string;
}

export interface LoginResponseT extends BaseResponseT {
  emailStatus?: `${EmailStatusEnum}`;
  expires?: number;
  loginStatus?: `${LoginStatusEnum}`;
  taxNumber?: number;
  userPermissions?: UserPermissionsType;
}

export interface LogoutResponseT extends BaseResponseT {
  loginStatus?: `${LoginStatusEnum}`;
}

export interface ValidateEmailAddressRequestT {
  emailCode: string;
}

export interface UsersSliceT {
  loginStatus: `${LoginStatusEnum}`;
  expires: number;
  taxNumber: number;
  userPermissions: UserPermissionsType;
  emailStatus: `${EmailStatusEnum}`;
  outcome: OutcomeT;
  message: string;
}
