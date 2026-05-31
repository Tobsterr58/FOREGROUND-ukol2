<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const isScrolled = ref(false);

const handleScroll = () => {
    isScrolled.value = window.scrollY > 50;
};

onMounted(() => {
    window.addEventListener('scroll', handleScroll);
});

onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
});
</script>

<template>
    <nav :class="['fixed w-full z-50 transition-all duration-300', isScrolled ? 'bg-white shadow-md py-4' : 'bg-transparent py-6']">
        <div class="max-w-7xl mx-auto px-6 md:px-12 flex justify-between items-center">
            <a href="#" :class="['text-2xl font-bold tracking-tighter transition-colors', isScrolled ? 'text-gray-900' : 'text-white']">
                UN<span class="text-brand">CODE.</span>
            </a>
            
            <div class="hidden md:flex space-x-8">
                <a href="#home" :class="['text-sm font-medium hover:text-brand transition-colors', isScrolled ? 'text-gray-600' : 'text-gray-200']">Domov</a>
                <a href="#services" :class="['text-sm font-medium hover:text-brand transition-colors', isScrolled ? 'text-gray-600' : 'text-gray-200']">Služby</a>
                <a href="#portfolio" :class="['text-sm font-medium hover:text-brand transition-colors', isScrolled ? 'text-gray-600' : 'text-gray-200']">Portfólio</a>
            </div>

            <button class="md:hidden text-gray-500 focus:outline-none">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                </svg>
            </button>
        </div>
    </nav>
</template>