<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue';

// Import videa
import heroVideo from '../assets/f1-video.mp4';

// Premenné
const scrollY = ref(0);
let ticking = false;

// Funkcia na plynulý scroll listener
const handleScroll = () => {
    if (!ticking) {
        window.requestAnimationFrame(() => {
            scrollY.value = window.scrollY;
            ticking = false;
        });
        ticking = true;
    }
};

// Event listenery
onMounted(() => {
    window.addEventListener('scroll', handleScroll, { passive: true });
});

onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
});

// Parallax výpočty
const parallaxVideoStyle = computed(() => ({
    transform: `translateY(${scrollY.value * 0.4}px)`
}));

const parallaxContentStyle = computed(() => ({
    transform: `translateY(${scrollY.value * 0.55}px)`
}));

// Funkcia na posunutie nadol
const scrollDown = () => {
    window.scrollTo({
        top: window.innerHeight, 
        behavior: 'smooth'
    });
};
</script>

<template>
    <section id="home" class="relative h-screen flex items-center justify-center overflow-hidden bg-[#111827]">
        
        <div class="absolute inset-0 z-0" :style="parallaxVideoStyle">
            <video 
                autoplay 
                loop 
                muted 
                playsinline 
                class="w-full h-full object-cover scale-110 origin-center"
            >
                <source :src="heroVideo" type="video/mp4" />
                Váš prehliadač nepodporuje video tag.
            </video>
            
            <div class="absolute inset-0 bg-[#111827]/70"></div>
        </div>
    
        <div class="relative z-10 w-full h-full flex flex-col items-center justify-center" :style="parallaxContentStyle">
            
            <div class="text-center px-4 max-w-4xl mx-auto flex flex-col items-center justify-center h-full" data-aos="fade-up" data-aos-duration="1000">
                <div class="flex-grow flex flex-col items-center justify-center mt-12">
                    <h1 class="text-5xl md:text-7xl lg:text-8xl font-bold text-white mb-6 leading-tight tracking-tighter">
                        Zažite rýchlosť <br/>
                        <span class="text-transparent bg-clip-text bg-gradient-to-r from-orange-400 to-red-500">Kráľovnej Motoršportu</span>
                    </h1>
                    <p class="text-lg md:text-xl text-gray-300 max-w-2xl mx-auto font-light leading-relaxed">
                        Svet Formuly 1 prináša dokonalú symbiózu inžinierskej precíznosti, nekompromisného dizajnu a čistého adrenalínu na trati.
                    </p>
                </div>
                
                <div class="pb-32">
                    <button 
                        @click="scrollDown" 
                        class="inline-flex items-center justify-center w-19 h-19 rounded-full border border-white/40 text-white hover:bg-[#ff8000] hover:text-white hover:border-[#ff8000] focus:outline-none shadow-[0_0_20px_rgba(255,128,0,0.3)] hover:shadow-[0_0_30px_rgba(255,128,0,0.6)] transition-all duration-300"
                        aria-label="Pokračovať nižšie"
                    >
                        <svg class="w-6 h-6 mt-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 14l-7 7m0 0l-7-7m7 7V3"></path>
                        </svg>
                    </button>
                </div>
            </div>

        </div>
    </section>
</template>