<script setup lang="ts">
import type { Product, TransformedProduct } from "../../../types";

const route = useRoute();

type DetailResponse = Omit<TransformedProduct, "to">;

const { data, pending } = useAsyncData<DetailResponse>("detail", () => {
  return new Promise((resolve) => {
    $fetch<Product>(`https://dummyjson.com/products/${route.params.id}`, {
      method: "GET",
      query: {
        delay: 1000,
        select: "id,description,title,price,tags,thumbnail",
      },
    }).then((res) => {
      const transformedData: Omit<DetailResponse, "to"> = {
        id: res.id,
        title: res.title,
        description: res.description,
        date: Intl.NumberFormat("en-US", { style: "currency", currency: "USD" })
          .format(parseFloat(res.price))
          .toString(),
        badge: res.tags[0],
        image: res.thumbnail,
      };

      resolve(transformedData);
    });
  });
});
</script>

<template>
  <div classs="flex flex-col justify-center items-center gap-4 w-full">
    <div class="flex justify-center w-full mt-5">
      <div class="flex flex-col w-full" v-if="pending">
        <USkeleton class="w-full h-160" />
        <USkeleton class="w-50 h-6 mt-2" />
        <USkeleton class="w-full h-6 mt-2" />
        <USkeleton class="w-full h-6 mt-2" />
      </div>

      <UBlogPost
        v-else
        :title="data?.title"
        :description="data?.description"
        :image="data?.image"
        :date="data?.date"
        :badge="data?.badge"
      />
    </div>
  </div>
</template>

<style lang="scss" scoped></style>
