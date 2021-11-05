import { BaseResponseT, OutcomeT } from './commonTypes';

export enum UserPermissionsEnum {
  INACTIVE = 'INACTIVE',
  REGULAR = 'REGULAR',
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

export enum UserStatusEnum {
  ACTIVE = 'ACTIVE',
  INACTIVE = 'INACTIVE',
}

export interface UpdateProfileRequestT {
  taxNumber: number;
  userRealName?: string;
  companyName?: string;
  userEmail?: string;
  userStatus?: `${UserStatusEnum}`;
  emailStatus?: `${EmailStatusEnum}`;
  ownEmail?: boolean;
  password?: string;
  attempts?: boolean;
  userPermissions?: `${UserPermissionsEnum}`[];
}

interface UserRealNameResponseT extends BaseResponseT {
  value: 'userRealName';
  userRealName?: string;
}

interface CompanyNameResponseT extends BaseResponseT {
  value: 'companyName';
  companyName?: string;
}

interface UserStatusResponseT extends BaseResponseT {
  value: 'userStatus';
  userStatus: `${UserStatusEnum}`;
}

export interface ModifyEmailResponseT extends BaseResponseT {
  value: 'userEmail';
  emailStatus?: `${EmailStatusEnum}`;
  userEmail: string;
  ownEmail: boolean;
}

interface ModifyPasswordResponseT extends BaseResponseT {
  value: 'password';
}

interface AttemptsResponseT extends BaseResponseT {
  value: 'attempts';
}

interface UserPermissionsResponseT extends BaseResponseT {
  value: 'userPermissions';
  userPermissions: `${UserPermissionsEnum}`[];
}

export type UpdateProfileResponseT = [
  UserRealNameResponseT?,
  CompanyNameResponseT?,
  UserStatusResponseT?,
  ModifyEmailResponseT?,
  ModifyPasswordResponseT?,
  AttemptsResponseT?,
  UserPermissionsResponseT?,
];

export interface EmailValidationRequestT {
  emailCode: string;
}

export interface EmailValidationResponseT extends BaseResponseT {
  emailStatus: EmailStatusEnum;
}

export interface LoginRequestT {
  taxNumber: number;
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

export interface UserSliceT {
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
