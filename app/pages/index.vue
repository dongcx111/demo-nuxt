<script setup></script>

<template>
  <div class="w-screen h-screen absolute top-0 left-0 z-10">
    <BackgroundDotGrid
      :dot-size="2"
      :gap="12"
      base-color="#27FF64"
      active-color="#27FF64"
      :proximity="150"
      :speed-trigger="100"
      :shock-radius="250"
      :shock-strength="5"
      :max-speed="5000"
      :resistance="750"
      :return-duration="1.5"
      class-name="custom-dot-grid min-h-screen"
    />
  </div>

  <div
    class="w-screen h-screen absolute top-0 left-0 z-50 flex items-center justify-center flex-col"
  >
    <h1 class="text-4xl font-bold mb-4">Welcome to my Blog!</h1>
    <p class="text-lg text-gray-600">This is the index page.</p>
  </div>
</template>

<style scoped>
.dot-grid-container {
  width: 100%;
  height: 500px;
  position: relative;
  overflow: hidden;
}
</style>
