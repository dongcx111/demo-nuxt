<script setup lang="ts">
import type { ProductResponse, TransformedProduct, TransformedProductResponse } from "../../types";
const router = useRouter();

const toDetail = () => {
  router.push("/blog/detail");
};

const page = ref(1);

const total = ref(0);

const products = ref<TransformedProduct[]>([]);

const { data, pending } = useAsyncData<TransformedProductResponse>(
  "list",
  () => {
    return new Promise((resolve) => {
      $fetch<ProductResponse>("https://dummyjson.com/products", {
        method: "GET",
        query: {
          delay: 1000,
          limit: 9,
          skip: (page.value - 1) * 9,
          select: "id,description,title,price,tags,thumbnail",
        },
      }).then((res) => {
        const transformedData: TransformedProductResponse = {
          total: res.total,
          skip: res.skip,
          limit: res.limit,
          products: [],
        };

        transformedData.products = res.products.map((product) => ({
          id: product.id,
          title: product.title,
          description: product.description,
          date: Intl.NumberFormat("en-US", { style: "currency", currency: "USD" })
            .format(parseFloat(product.price))
            .toString(),
          badge: product.tags[0],
          image: product.thumbnail,
          to: `/blog/detail/${product.id}`,
        }));
        resolve(transformedData);
      });
    });
  },
  {
    watch: [page],
    getCachedData: (key, nuxtApp, ctx) => {
      // 自定义缓存逻辑
      return nuxtApp.static.data[key];
    },
  },
);

watch(pending, () => {
  total.value = data.value?.total || 0;
  products.value = data.value?.products || [];
});
</script>

<template>
  <div class="flex flex-col justify-center items-center pt-5">
    <div class="grid grid-cols-3 grid-rows-3 w-full gap-8 place-items-center" v-if="pending">
      <BlogSkeleton v-for="i in 9" :key="i" />
    </div>
    <UEmpty
      v-else-if="products.length === 0"
      variant="naked"
      icon="i-lucide-file"
      title="No productions"
      description="There are no products to display."
    />
    <UBlogPosts :posts="products" v-else :ui="{ base: 'flex flex-col gap-8 lg:gap-y-8' }" />
    <UPagination v-model:page="page" :total="total" class="pt-5" />
  </div>
</template>

<style lang="scss" scoped></style>
