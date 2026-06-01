<script setup>
import { onMounted } from 'vue'
import AOS from 'aos'
import 'aos/dist/aos.css'

// Importujeme naše komponenty
import Navbar from './components/Navbar.vue'
import FloatingElements from './components/FloatingElements.vue'
import HeroSection from './components/HeroSection.vue'
import AboutSection from './components/AboutSection.vue'
import Services from './components/Services.vue'
import PortfolioGrid from './components/PortfolioGrid.vue'
import LandoStats from './components/LandoStats.vue'
import Video from './components/Video.vue'
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
    <AboutSection />
    <PortfolioGrid />
    <LandoStats />
    <Services />
    <Video>
      <Footer />
    </Video>
    <FloatingElements />
  </div>
</template>