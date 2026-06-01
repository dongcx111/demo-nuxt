export interface Product {
  id: number;
  description: string;
  title: string;
  price: string;
  tags: string[];
  thumbnail: string;
}

export interface ProductResponse {
  products: Product[];
  total: number;
  skip: number;
  limit: number;
}

export type TransformedProduct = Omit<Product, "price" | "tags" | "thumbnail"> & {
  date: string;
  badge: string | undefined;
  image: string;
  to: string;
};

export type TransformedProductResponse = Pick<ProductResponse, "total" | "skip" | "limit"> & {
  products: TransformedProduct[];
};
