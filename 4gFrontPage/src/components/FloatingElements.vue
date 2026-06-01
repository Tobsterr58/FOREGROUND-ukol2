<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

// Stav pre zobrazenie tlačidla "Scroll to Top"
const showScrollTop = ref(false);

const handleScroll = () => {
    // Zobrazí tlačidlo, ak sme odscrollovali viac ako 100vh (výška okna)
    showScrollTop.value = window.scrollY > window.innerHeight;
};

const scrollToTop = () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
};

// Dáta pre bočné F1 menu
const sidebarItems = [
    {
        id: 1,
        name: 'Telemetria',
        // Ikona ozubeného kolesa (Nastavenia/Telemetria)
        icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>'
    },
    {
        id: 2,
        name: 'Live Chat',
        // Ikona bubliny
        icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"></path>'
    },
    {
        id: 3,
        name: 'Fanzóna',
        // Ikona srdca
        icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>'
    },
    {
        id: 4,
        name: 'Paddock Pass',
        // Ikona vstupenky/knihy
        icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"></path>'
    },
    {
        id: 5,
        name: 'Onboard Kamery',
        // Ikona kamery
        icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"></path>'
    }
];

onMounted(() => {
    window.addEventListener('scroll', handleScroll, { passive: true });
});

onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
});
</script>

<template>
    <div class="fixed-ui-container z-50">
        
        <div class="fixed top-1/2 right-0 transform -translate-y-1/2 bg-white shadow-[0_4px_15px_rgba(0,0,0,0.15)] rounded-l-lg flex flex-col py-1 z-50">
            
            <!-- Menší vnútorný okraj pre položky (p-2 namiesto p-3) -->
            <a href="#" v-for="item in sidebarItems" :key="item.id" 
               class="relative group p-2 text-gray-400 hover:text-[#e83e8c] transition-colors flex items-center justify-center">
                
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" v-html="item.icon"></svg>

                <div class="absolute right-full top-1/2 transform -translate-y-1/2 mr-2 opacity-0 group-hover:opacity-100 group-hover:translate-x-0 translate-x-1 pointer-events-none transition-all duration-300">
                    <!-- Menší font (text-xs), menší padding (py-1 px-3) -->
                    <div class="bg-white text-gray-800 text-xs font-semibold py-1 px-3 rounded shadow-lg whitespace-nowrap relative flex items-center">
                        {{ item.name }}
                        <!-- Malý trojuholník smerujúci doprava -->
                        <div class="absolute top-1/2 -right-1 transform -translate-y-1/2 w-1.5 h-1.5 bg-white rotate-45"></div>
                    </div>
                </div>
                
            </a>
            
        </div>

        <Transition name="fade-up">
            <button v-if="showScrollTop" 
                    @click="scrollToTop"
                    class="fixed bottom-6 right-6 w-8 h-8 bg-[#111827] hover:bg-[#e83e8c] text-white rounded shadow-xl flex items-center justify-center transition-colors z-50 cursor-pointer group"
                    aria-label="Späť hore">
                <svg class="w-4 h-4 transform group-hover:-translate-y-0.5 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 15l7-7 7 7"></path>
                </svg>
            </button>
        </Transition>

    </div>
</template>

<style scoped>
/* Plynulá animácia pre vynorenie šípky zdola */
.fade-up-enter-active,
.fade-up-leave-active {
    transition: all 0.3s ease-out;
}

.fade-up-enter-from,
.fade-up-leave-to {
    opacity: 0;
    transform: translateY(10px);
}
</style>