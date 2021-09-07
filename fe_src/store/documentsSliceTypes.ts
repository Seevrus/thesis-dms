export enum DocumentCategory {
  PAYROLL = 1,
  INFORMATION_LETTER = 2,
}

export interface DocumentRequestT {
  documentId: number;
}

export interface FetchDocumentsRequestT {
  fetchFrom?: number;
  category?: DocumentCategory;
}

export interface DocumentT {
  id: number;
  documentName: string;
  category: string;
  added: Date;
  downloadedAt: Date;
  validUntil: Date;
}
