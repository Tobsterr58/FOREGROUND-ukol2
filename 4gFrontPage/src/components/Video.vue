<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const props = defineProps({
    videoId: { type: String, default: '8QkugFzZKV4' },
    thumbnail: { type: String, default: null }
});

const isOpen = ref(false);
const wrapperRef = ref(null);

// Táto premenná riadi parallax posun celého footra
// Začíname na hodnote -150px (zasunuté 150px pod videom)
const footerTranslateY = ref(-150);

const thumbnailUrl = props.thumbnail
    ?? `https://img.youtube.com/vi/${props.videoId}/maxresdefault.jpg`;

const handleScroll = () => {
    if (!wrapperRef.value) return;

    const rect = wrapperRef.value.getBoundingClientRect();
    const windowHeight = window.innerHeight;

    // Koľko pixelov z footra už "vstúpilo" zospodu na obrazovku
    const visiblePx = windowHeight - rect.top;

    // Ak ešte footer nie je vôbec na obrazovke, držíme ho schovaný
    if (visiblePx <= 0) {
        footerTranslateY.value = -150;
        return;
    }

    // Vypočítame progres (0 = footer práve začal vyliezať, 1 = sme na úplnom konci footra/stránky)
    const totalDistance = rect.height;
    let progress = visiblePx / totalDistance;
    progress = Math.max(0, Math.min(1, progress));

    // Postupné "vyplazovanie jazyka": z -150px klesá na 0px podľa scrollovania
    footerTranslateY.value = -150 * (1 - progress);
};

onMounted(() => {
    window.addEventListener('scroll', handleScroll, { passive: true });
    // Zavoláme hneď pri štarte pre správne úvodné nastavenie
    handleScroll();
});

onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
});

const openVideo = () => { isOpen.value = true; };
const closeVideo = () => { isOpen.value = false; };
const handleKeydown = (e) => { if (e.key === 'Escape') closeVideo(); };
</script>

<template>
    <!-- Celkový obal pre Video a Footer -->
    <div class="relative w-full bg-[#111827]">

        <!-- ============================== -->
        <!-- 1. VIDEO (Ústa)                -->
        <!-- ============================== -->
        <!-- Z-index 20 drží video NAD footerom, takže sa footer môže vysúvať spopod neho -->
        <div class="relative w-full z-20 shadow-[0_20px_50px_rgba(0,0,0,0.8)]" style="height: 60vh;">
            <img :src="thumbnailUrl" alt="Video cover" class="w-full h-full object-cover" />

            <!-- Čistý a nemenný tmavý overlay -->
            <div class="absolute inset-0 bg-black/30"></div>

            <!-- Play tlačidlo (žiadne ďalšie texty) -->
            <div class="absolute inset-0 flex items-center justify-center">
                <button @click="openVideo"
                        class="w-16 h-16 rounded-full bg-white/90 hover:bg-white flex items-center justify-center transition-transform duration-300 hover:scale-110 cursor-pointer"
                        aria-label="Prehrať video">
                    <svg class="w-6 h-6 text-gray-900 ml-1" fill="currentColor" viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>
                </button>
            </div>
        </div>

        <!-- ============================== -->
        <!-- 2. FOOTER (Jazyk)              -->
        <!-- ============================== -->
        <!-- Z-index 10 (pod videom) a overflow-hidden zabezpečí, že nič nepresahuje -->
        <div class="relative w-full z-10 bg-[#111827] overflow-hidden" ref="wrapperRef">
            
            <!-- Tento div robí ten vizuálny "reveal" efekt posunom Y nadol -->
            <div class="w-full flex flex-col will-change-transform"
                 :style="{ transform: `translateY(${footerTranslateY}px)` }">

                <!-- Horná časť footra (Nadpis a Tlačidlo presne ako na tvojom vzore) -->
                <div class="w-full pt-20 pb-10 px-6 text-center">
                    <h2 class="text-4xl md:text-5xl lg:text-6xl font-bold tracking-tight text-white leading-tight mb-8 drop-shadow-md">
                        We'd love to build<br>something amazing
                    </h2>
                    <button class="inline-flex items-center gap-2 px-7 py-3 bg-[#e83e8c] hover:bg-[#d0336f] text-white font-semibold rounded-full transition-all hover:scale-105 text-sm shadow-lg">
                        Buy Now · $59
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/></svg>
                    </button>
                </div>

                <!-- 
                  Miesto pre tvoj originálny kód so 4 stĺpcami z App.vue 
                  (Sem zapadne tvoj <footer class="bg-[#111827]...">...</footer>)
                -->
                <div class="w-full">
                    <slot></slot>
                </div>

            </div>
        </div>

    </div>

    <!-- Modal pre prehrávanie YouTube videa -->
    <Teleport to="body">
        <Transition name="fade">
            <div v-if="isOpen"
                 class="fixed inset-0 z-[100] flex items-center justify-center bg-black/90"
                 @click.self="closeVideo"
                 @keydown="handleKeydown"
                 tabindex="-1">
                <button @click="closeVideo"
                        class="absolute top-5 right-5 text-white hover:text-gray-300 transition-colors z-10"
                        aria-label="Zatvoriť video">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
                <div class="w-full max-w-5xl mx-6 aspect-video shadow-2xl">
                    <iframe v-if="isOpen"
                            :src="`https://www.youtube.com/embed/${videoId}?autoplay=1&rel=0`"
                            class="w-full h-full rounded-xl"
                            frameborder="0"
                            allow="autoplay; fullscreen; picture-in-picture"
                            allowfullscreen></iframe>
                </div>
            </div>
        </Transition>
    </Teleport>
</template>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.25s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>