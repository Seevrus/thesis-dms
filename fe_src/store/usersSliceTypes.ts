import { BaseResponseT, OutcomeT } from './commonTypes';

export enum UserPermissionsEnum {
  INACTIVE = 'INACTIVE',
  USER = 'USER',
  ACTIVITY_ADMINISTRATOR = 'ACTIVITY_ADMINISTRATOR',
  USER_ADMINISTRATOR = 'USER_ADMINISTRATOR',
  DOCUMENT_CREATOR = 'DOCUMENT_CREATOR',
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
  taxNumber: number;
  email: string;
  password: string;
}

export interface ModifyEmailResponseT extends BaseResponseT {
  value: 'email';
  emailStatus?: EmailStatusEnum;
}

interface ModifyPasswordResponseT extends BaseResponseT {
  value: 'password';
}

export type CompleteRegistrationResponseT = [
  ModifyEmailResponseT,
  ModifyPasswordResponseT,
];

export interface EmailValidationRequestT {
  emailCode: string;
}

export interface EmailValidationResponseT extends BaseResponseT {
  emailStatus: EmailStatusEnum;
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
  companyName?: string;
  userRealName?: string;
  userEmail?: string;
  userPermissions?: `${UserPermissionsEnum}`[];
}

export interface LogoutResponseT extends BaseResponseT {
  loginStatus?: `${LoginStatusEnum}`;
}

export interface UsersSliceT {
  loginStatus: `${LoginStatusEnum}`;
  expires: number;
  taxNumber: number;
  companyName: string;
  userRealName: string;
  userPermissions: `${UserPermissionsEnum}`[];
  userEmail: string;
  emailStatus: `${EmailStatusEnum}`;
  outcome: OutcomeT;
  message: string;
}
