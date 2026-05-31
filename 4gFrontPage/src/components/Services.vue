<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';

const items = [
    { 
        id: 1, 
        name: 'Soft (C5/C4)', 
        date: 'Kvalifikácia & Šprint', 
        desc: 'Červená zmes. Extrémna rýchlosť a priľnavosť, no veľmi rýchla degradácia. Ideálne na záverečný útok.', 
        image: 'https://tyre-assets.pirelli.com/staticfolder/Tyre/resources/img/red-parentesi.png', 
        color: '#ff003c' 
    },
    { 
        id: 2, 
        name: 'Medium (C3)', 
        date: 'Hlavný závod', 
        desc: 'Žltá zmes. Zlatá stredná cesta medzi priľnavosťou a životnosťou. Najpoužívanejšia preteková pneumatika.', 
        image: 'https://tyre-assets.pirelli.com/staticfolder/Tyre/resources/img/yellow-parentesi.png', 
        color: '#ffcc00' 
    },
    { 
        id: 3, 
        name: 'Hard (C2/C1)', 
        date: 'Dlhé stinty', 
        desc: 'Biela zmes. Najtvrdšia zmes na víkend. Pomalšie sa zahrieva, no vydrží obrovskú záťaž a desiatky kôl.', 
        image: 'https://tyre-assets.pirelli.com/staticfolder/Tyre/resources/img/white-parentesi.png',
        color: '#ffffff' 
    },
    { 
        id: 4, 
        name: 'Intermediate', 
        date: 'Prechodné', 
        desc: 'Zelená zmes. Pre vlhkú trať alebo vysychajúcu stopu. Dokáže odviesť 30 litrov vody za sekundu pri rýchlosti 300 km/h.', 
        image: 'https://tyre-assets.pirelli.com/images/global/380/862/cinturato-green-intermediate-4505508953587.png', 
        color: '#00e640' 
    },
    { 
        id: 5, 
        name: 'Full Wet', 
        date: 'Silný dážď', 
        desc: 'Modrá zmes. Pneumatika do extrémnych podmienok. Odvedie neuveriteľných 85 litrov vody za sekundu.', 
        image: 'https://tyre-assets.pirelli.com/images/global/968/233/cinturato-blue-wet-4505508953865.png',                                                                                                                                             
        color: '#0066ff' 
    }
];

const carouselRef = ref(null);
const currentPage = ref(1);
const itemsPerPage = ref(4);
const isAtStart = ref(true);
const isAtEnd = ref(false);

const totalPages = computed(() => Math.ceil(items.length / itemsPerPage.value));

const GAP = 24; // px, must match CSS gap

const handleScroll = () => {
    if (!carouselRef.value || !carouselRef.value.children[0]) return;
    const { scrollLeft, scrollWidth, clientWidth } = carouselRef.value;
    isAtStart.value = scrollLeft <= 2;
    isAtEnd.value = Math.ceil(scrollLeft + clientWidth) >= scrollWidth - 10;
    const itemWidth = carouselRef.value.children[0].offsetWidth;
    const currentIndex = Math.round(scrollLeft / (itemWidth + GAP));
    currentPage.value = Math.floor(currentIndex / itemsPerPage.value) + 1;
};

const nextPage = () => {
    if (!carouselRef.value || !carouselRef.value.children[0]) return;
    const itemWidth = carouselRef.value.children[0].offsetWidth;
    carouselRef.value.scrollBy({ left: (itemWidth + GAP) * itemsPerPage.value, behavior: 'smooth' });
};

const prevPage = () => {
    if (!carouselRef.value || !carouselRef.value.children[0]) return;
    const itemWidth = carouselRef.value.children[0].offsetWidth;
    carouselRef.value.scrollBy({ left: -(itemWidth + GAP) * itemsPerPage.value, behavior: 'smooth' });
};

const mouseX = ref(-200);
const mouseY = ref(-200);
const activeHoverId = ref(null);
const cursorColor = ref('#e83e8c');
const cursorIconColor = ref('#ffffff');

const updateMousePosition = (e) => {
    mouseX.value = e.clientX;
    mouseY.value = e.clientY;
};

const handleMouseEnter = (item) => {
    activeHoverId.value = item.id;
    cursorColor.value = item.color;
    // Black cross on white/near-white tyre, white cross everywhere else
    cursorIconColor.value = item.color === '#ffffff' ? '#000000' : '#ffffff';
};

const handleMouseLeave = () => {
    activeHoverId.value = null;
};

onMounted(() => {
    window.addEventListener('mousemove', updateMousePosition);
});
onUnmounted(() => {
    window.removeEventListener('mousemove', updateMousePosition);
});
</script>

<template>
    <section class="bg-white py-16 overflow-hidden">

        <!-- Hlavička: zarovnaná s kartami -->
        <div class="max-w-7xl mx-auto px-6 md:px-12 w-full mb-10 flex items-center justify-between">
            <h2 class="text-4xl md:text-5xl font-bold text-gray-900 tracking-tight">Pirelli Pneumatiky</h2>
        </div>

        <!-- Karusel s kartami -->

           <div class="w-full relative mb-10">
                <div
                    ref="carouselRef"
                    @scroll="handleScroll"
                    class="flex gap-6 overflow-x-auto snap-x snap-mandatory no-scrollbar"
                    :style="{
                        paddingLeft: 'max(1.5rem, calc((100vw - 80rem) / 2 + 3rem))',
                        paddingRight: 'max(1.5rem, calc((100vw - 80rem) / 2 + 3rem))',
                        scrollPaddingLeft: 'max(1.5rem, calc((100vw - 80rem) / 2 + 3rem))'
                    }"
                >
                    <div
                        v-for="item in items"
                        :key="item.id"
                        class="snap-start flex-shrink-0 w-[60%] sm:w-[45%] md:w-[26%] lg:w-[30%] group md:cursor-none flex flex-col"
                        @mouseenter="handleMouseEnter(item)"
                        @mouseleave="handleMouseLeave"
                    >
                        <div class="w-full aspect-[4/3] bg-gray-100 overflow-hidden mb-5 relative">
                            <img
                                :src="item.image"
                                :alt="item.name"
                                class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                            />
                        </div>
                        <div class="flex flex-col flex-grow">
                            <span class="text-xs text-gray-400 mb-2 tabular-nums">{{ item.date }}</span>
                            <h4 class="text-lg font-bold text-gray-900 mb-2 leading-snug tracking-tight">{{ item.name }}</h4>
                            <p class="text-gray-500 text-sm leading-relaxed">{{ item.desc }}</p>
                        </div>
                    </div>
                </div>
            </div>

        <!-- Navigácia: zarovnaná s kartami -->
        <div class="max-w-7xl mx-auto px-6 md:px-12 w-full flex justify-start items-center space-x-4">
            <button
                @click="prevPage"
                :disabled="isAtStart"
                class="text-gray-900 disabled:text-gray-300 hover:text-gray-500 transition-colors"
                aria-label="Späť"
            >
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 19l-7-7 7-7"/>
                </svg>
            </button>

            <span class="text-sm text-gray-900 tracking-wide">{{ currentPage }}/{{ totalPages }}</span>

            <button
                @click="nextPage"
                :disabled="isAtEnd"
                class="text-gray-900 disabled:text-gray-300 hover:text-gray-500 transition-colors"
                aria-label="Ďalej"
            >
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5l7 7-7 7"/>
                </svg>
            </button>
        </div>

        <!-- Vlastný kurzor -->
        <div
            class="hidden md:flex fixed top-0 left-0 pointer-events-none z-50 items-center justify-center"
            :style="{
                transform: `translate(${mouseX}px, ${mouseY}px) translate(-50%, -50%)`,
                width: '64px',
                height: '64px',
                opacity: activeHoverId ? 1 : 0,
                transition: 'opacity 0.15s ease'
            }"
        >
            <div
                class="absolute inset-0 rounded-full"
                :style="{ backgroundColor: cursorColor, boxShadow: '0 4px 20px rgba(0,0,0,0.15)' }"
            ></div>
            <!-- Krížik: čierny pre Hard (biela zmes), biely pre ostatné -->
            <svg
                class="relative z-10 w-5 h-5"
                fill="none"
                :stroke="cursorIconColor"
                viewBox="0 0 24 24"
            >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
            </svg>
        </div>
    </section>
</template>

<style scoped>
.no-scrollbar::-webkit-scrollbar { display: none; }
.no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
</style>