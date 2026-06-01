<script setup></script>

<template>
  <LayoutHeader />
  <UMain>
    <UContainer class="min-h-[calc(100vh-var(--ui-header-height))]">
      <slot></slot>
    </UContainer>
  </UMain>
</template>

<style lang="scss" scoped></style>
