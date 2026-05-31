<script setup>
import { onMounted } from 'vue'
import AOS from 'aos'
import 'aos/dist/aos.css'

// Importujeme naše komponenty
import Navbar from './components/Navbar.vue'
import HeroSection from './components/HeroSection.vue'
import Services from './components/Services.vue'
import PortfolioGrid from './components/PortfolioGrid.vue'
import Footer from './components/Footer.vue'

// Inicializácia animácií po načítaní aplikácie
onMounted(() => {
  AOS.init({
    duration: 800,
    easing: 'ease-in-out',
    once: true,
    offset: 100
  })
})
</script>

<template>
  <div class="bg-gray-50 text-gray-900 font-sans">
    <Navbar />
    <HeroSection />
    <Services />
    <PortfolioGrid />
    <Footer />
  </div>
</template>