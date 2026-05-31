<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

// Dáta pre tímy F1 - farby zodpovedajú identite tímov
const projects = ref([
    { 
        id: 1, 
        name: 'Scuderia Ferrari', 
        color: '#dc0000', // Ferrari Red
        image: 'https://www.motaauto.com/wp-content/uploads/2024/02/Ferrari-Sf-24-F1-2024-6-scaled.jpg', 
        isLarge: true // Veľký vľavo hore
    },
    { 
        id: 2, 
        name: 'McLaren', 
        color: '#ff8000', // Papaya Orange
        image: 'https://wallpapercave.com/wp/wp14065497.jpg', 
        isLarge: false 
    },
    { 
        id: 3, 
        name: 'Red Bull Racing', 
        color: '#0600ef', // Red Bull Dark Blue
        image: 'https://wallpapers4screen.com/Uploads/18-1-2026/98090/thumb2-2026-red-bull-rb22-formula-1-4k-front-view.jpg', 
        isLarge: false 
    },
    { 
        id: 4, 
        name: 'Mercedes-AMG', 
        color: '#00d2be', // Mercedes Teal
        image: 'https://wallpaper.forfun.com/fetch/2f/2f2596c3486d1523a28582d823b0b3f6.jpeg', 
        isLarge: false 
    },
    { 
        id: 5, 
        name: 'Aston Martin', 
        color: '#006f62', // British Racing Green
        image: 'https://wallpaperaccess.com/full/5603711.jpg', 
        isLarge: true // Veľký vpravo dole
    },
    { 
        id: 6, 
        name: 'Alpine', 
        color: '#fd4bc7', // Alpine Pink
        image: 'https://www.f1-fansite.com/wp-content/uploads/2021/03/Alpine_F1_Team_1_1600-1.jpg', 
        isLarge: false 
    }
]);

// Logika pre sledovanie myši
const mouseX = ref(0);
const mouseY = ref(0);
const activeProject = ref(null); // Uchováva informáciu, nad ktorým tímom sme práve myšou

const updateMousePosition = (e) => {
    mouseX.value = e.clientX;
    mouseY.value = e.clientY;
};

// Zapnutie sledovania myši na celej obrazovke
onMounted(() => {
    window.addEventListener('mousemove', updateMousePosition);
});

onUnmounted(() => {
    window.removeEventListener('mousemove', updateMousePosition);
});
</script>

<template>
    <!-- Relative wrapper dôležitý pre ukotvenie, hoci kurzor je fixný -->
    <section id="portfolio" class="bg-brand-900 relative">
        
        <!-- CSS Grid pre Masonry efekt. Na desktope 3 stĺpce, auto výška riadkov -->
        <div class="grid grid-cols-1 md:grid-cols-3 md:grid-rows-4 w-full h-[150vh] md:h-[180vh]">
            
            <div v-for="(project, index) in projects" :key="project.id"
                 @mouseenter="activeProject = project"
                 @mouseleave="activeProject = null"
                 :class="[
                     'relative overflow-hidden group', 
                     /* Na desktope nastavíme kurzor na žiadny (aby sme ukázali vlastný), na mobile štandardný */
                     'md:cursor-none cursor-pointer',
                     /* Dynamické triedy pre veľkosť - prvý a piaty obrázok dostanú col-span-2 a row-span-2 */
                     project.isLarge ? 'md:col-span-2 md:row-span-2' : 'md:col-span-1 md:row-span-1'
                 ]"
                 data-aos="fade-in" :data-aos-delay="index * 100">
                
                <!-- Obrázok tímu. Zväčší sa na hover, ale kontajner (overflow-hidden) ho ohraničí -->
                <img :src="project.image" :alt="project.name" 
                     class="w-full h-full object-cover transition-transform duration-700 ease-out group-hover:scale-110 opacity-70 group-hover:opacity-100" />
            </div>

        </div>

        <!-- VLASTNÝ KURZOR (Plávajúci Element) -->
        <!-- Zobrazuje sa iba na desktope (hidden md:block) a iba vtedy, keď sme nad obrázkom -->
        <div class="hidden md:block fixed top-0 left-0 pointer-events-none z-50 transition-opacity duration-300"
             :style="{
                /* Okamžité sledovanie X/Y polohy myši. Translate(-50%, -50%) ho vycentruje na špičku kurzora */
                transform: `translate(${mouseX}px, ${mouseY}px) translate(-50%, -50%)`,
                opacity: activeProject ? 1 : 0
             }">
             
            <!-- Samotný štítok s farbou tímu -->
            <div v-if="activeProject"
                 class="px-6 py-3 rounded-full text-white text-sm font-bold tracking-widest uppercase shadow-2xl transition-colors duration-300 transform scale-110"
                 :style="{ backgroundColor: activeProject.color }">
                {{ activeProject.name }}
            </div>
            
        </div>
    </section>
</template>