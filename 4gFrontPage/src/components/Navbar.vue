<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';

const isScrolled = ref(false);
const isHoveringLink = ref(false);

// Aktívna kategória Mega Menu (null, 'jazdci', 'konstrukteri', 'zavody', 'historia')
const activeMenuCategory = ref(null);

// Kurzorová logika
const mouseX = ref(-100);
const mouseY = ref(-100);

const updateMousePosition = (e) => {
    mouseX.value = e.clientX;
    mouseY.value = e.clientY;
};

const handleScroll = () => {
    isScrolled.value = window.scrollY > 50;
};

// Aktuálny stav Promo Bloku (Špecifické hlavne pre Závody)
const activePromoImage = ref('');
const activePromoName = ref('');
const activePromoDesc = ref('');

// --- DÁTA PRE JEDNOTLIVÉ KATEGÓRIE ---

// 1. JAZDCI (22 jazdcov súčasnej éry + rezervní)
const jazdciData = ref([
    { name: 'Lando Norris', pts: 420, pos: 1 },
    { name: 'Max Verstappen', pts: 316, pos: 2 },
    { name: 'Charles Leclerc', pts: 298, pos: 3 },
    { name: 'Oscar Piastri', pts: 260, pos: 4 },
    { name: 'Carlos Sainz', pts: 245, pos: 5 },
    { name: 'George Russell', pts: 190, pos: 6 },
    { name: 'Lewis Hamilton', pts: 185, pos: 7 },
    { name: 'Sergio Perez', pts: 150, pos: 8 },
    { name: 'Fernando Alonso', pts: 85, pos: 9 },
    { name: 'Nico Hulkenberg', pts: 31, pos: 10 },
    { name: 'Yuki Tsunoda', pts: 28, pos: 11 },
    { name: 'Lance Stroll', pts: 24, pos: 12 },
    { name: 'Alex Albon', pts: 12, pos: 13 },
    { name: 'Esteban Ocon', pts: 11, pos: 14 },
    { name: 'Kevin Magnussen', pts: 10, pos: 15 },
    { name: 'Pierre Gasly', pts: 9, pos: 16 },
    { name: 'Franco Colapinto', pts: 5, pos: 17 },
    { name: 'Oliver Bearman', pts: 4, pos: 18 },
    { name: 'Zhou Guanyu', pts: 0, pos: 19 },
    { name: 'Valtteri Bottas', pts: 0, pos: 20 },
    { name: 'Liam Lawson', pts: 0, pos: 21 },
    { name: 'Jack Doohan', pts: 0, pos: 22 }
]);

// 2. KONŠTRUKTÉRI (Úlohy v tíme s SVG ikonkami)
const konstrukteriData = ref([
    {
        title: 'Pit Stop: Výmena Pneu',
        desc: 'Výmena všetkých 4 pneumatík za menej ako 2 sekundy vyžaduje dokonalú choreografiu 20 mechanikov.',
        // Ikonka pneumatiky
        icon: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><circle cx="12" cy="12" r="4"/><path d="M12 2v2"/><path d="M12 20v2"/><path d="M22 12h-2"/><path d="M4 12H2"/><path d="m4.93 4.93 1.41 1.41"/><path d="m17.66 17.66 1.41 1.41"/><path d="m4.93 19.07 1.41-1.41"/><path d="m17.66 6.34 1.41-1.41"/></svg>'
    },
    {
        title: 'Závodná Stratégia',
        desc: 'Matematici a stratégovia na pit wall počítajú každú desatinu sekundy pre ideálny undercut.',
        // Ikonka šachu / stratégie
        icon: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 3H3v18h18V3Z"/><path d="M21 9H3"/><path d="M21 15H3"/><path d="M9 21V3"/><path d="M15 21V3"/></svg>'
    },
    {
        title: 'Aerodynamika (Veterný tunel)',
        desc: 'Vývoj prítlaku a znižovanie odporu vzduchu pomocou CFD simulácií a zmenšených modelov.',
        // Ikonka vetra / prúdenia
        icon: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.59 4.59A2 2 0 1 1 11 8H2m10.59 11.41A2 2 0 1 0 14 16H2m15.73-8.27A2.5 2.5 0 1 1 19.5 12H2"/></svg>'
    },
    {
        title: 'Pohonná jednotka',
        desc: 'Hybridné V6 Turbo motory s rekuperáciou energie MGU-K a MGU-H patria k najefektívnejším na svete.',
        // Ikonka motora / blesku
        icon: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>'
    },
    {
        title: 'Analýza Telemetrie',
        desc: 'Monopost odošle milióny dátových bodov za sekundu. Inžinieri sledujú teploty, tlaky a opotrebenie v reálnom čase.',
        // Ikonka grafu / dát
        icon: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 3v18h18"/><path d="m19 9-5 5-4-4-3 3"/></svg>'
    },
    {
        title: 'Logistika a Transport',
        desc: 'Presun stoviek ton materiálu, garáží a motorhomov po celom svete s absolútnou presnosťou.',
        // Ikonka lietadla / transportu
        icon: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.8 19.2 16 11l3.5-3.5C21 6 21.5 4 21 3c-1-.5-3 0-4.5 1.5L13 8 4.8 6.2c-.5-.1-.9.2-1.1.6L3 8l6 5-4 4-3-1-1 1 2 4 4 2 1-1-1-3 4-4 5 6l1.2-.7c.4-.2.7-.6.6-1.1z"/></svg>'
    }
]);

// 3. ZÁVODY (Tvoje originálne a nedotknuté dáta)
const zavodyData = ref([
    {
        title: 'Európa',
        items: [
            { name: 'Monaco', desc: 'Circuit de Monaco, Monte Carlo', image: 'https://substackcdn.com/image/fetch/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F55d59502-51db-4f34-bfbc-2215360f9c10_895x539.png' },
            { name: 'Silverstone', desc: 'Silverstone Circuit, Veľká Británia', image: 'https://substackcdn.com/image/fetch/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe357ec1e-81e2-4c85-ae13-8d6a2f40a409_663x546.png' },
            { name: 'Monza', desc: 'Autodromo Nazionale Monza, Taliansko', image: 'https://substackcdn.com/image/fetch/$s_!Rh5z!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F326736c2-f42b-46fe-ac0d-334dcfa438ba_1200x630.png' },
            { name: 'Spa-Francorchamps', desc: 'Ardennes, Belgicko', image: 'https://substackcdn.com/image/fetch/w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F742a4712-a218-4dc5-a5d2-af8911a86bc4_817x558.png' }
        ]
    },
    {
        title: 'Amerika',
        items: [
            { name: 'Miami', desc: 'Miami International Autodrome, USA', image: 'https://tracinginsights.com/media/post_images/TracingInsights.com_Miami_Grand_Prix_Miami_International_Autodrome_Circuit_Characteristics.jpg' },
            { name: 'Austin', desc: 'Circuit of the Americas, USA', image: 'https://tracinginsights.com/media/post_images/TracingInsights.com__Austrian_Grand_Prix__Red_Bull_Ring__Circuit_Characteristics.jpg' },
            { name: 'Interlagos', desc: 'Autódromo José Carlos Pace, Brazília', image: 'https://tracinginsights.com/media/post_images/TracingInsights.com__Hungarian_Grand_Prix__Hungaroring__Circuit_Map.jpg' },
            { name: 'Las Vegas', desc: 'Las Vegas Strip Circuit, USA', image: 'https://substackcdn.com/image/fetch/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F909b27ba-5002-4d49-aac6-db3845946337_933x568.png' }
        ]
    },
    {
        title: 'Ázia a Blízky Východ',
        items: [
            { name: 'Suzuka', desc: 'Suzuka International Racing Course, Japonsko', image: 'https://tracinginsights.com/media/post_images/TracingInsights.com_Japanese_Grand_Prix_Suzuka_Circuit_Characteristics.jpeg' },
            { name: 'Bahrajn', desc: 'Bahrain International Circuit, Sakhir', image: 'https://tracinginsights.com/media/post_images/TracingInsights.com_Bahrain_Grand_Prix_Bahrain_International_Circuit_Characteristics.png' },
            { name: 'Singapur', desc: 'Marina Bay Street Circuit, Singapur', image: 'https://tracinginsights.com/media/post_images/TracingInsights.com_Bahrain_Grand_Prix_Jeddah_Corniche_Circuit_Characteristics.jpg' },
            { name: 'Jeddah', desc: 'Jeddah Corniche Circuit, Saudská Arábia', image: 'https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Faddafb0c-9987-4c74-8c26-2892b85d4a15_1509x972.png' }
        ]
    }
]);

// 4. HISTÓRIA (Momenty + Statický obrázok)
const historiaData = ref({
    moments: [
        { year: '1950', title: 'Zrod legendy: Prvé preteky v Silverstone' },
        { year: '1976', title: 'Epický duel: James Hunt vs. Niki Lauda' },
        { year: '1988', title: 'Dominancia McLarenu: MP4/4 a Senna s Prostom' },
        { year: '1994', title: 'Čierny víkend v Imole a odkaz Ayrtona Sennu' },
        { year: '2004', title: 'Červená éra: Michael Schumacher a jeho 7. titul' },
        { year: '2008', title: 'Dráma v poslednej zákrute: Hamiltonov prvý titul' },
        { year: '2021', title: 'Abu Dhabi: Verstappen vs. Hamilton v poslednom kole' }
    ],
    // Historický vintage záber monopostu
    image: 'https://i0.wp.com/speedsport.com/wp-content/uploads/2025/08/1974-McLaren-M23-05.jpg?fit=3628%2C2360&ssl=1' 
});

// Otvorenie menu
const openMenu = (category) => {
    isHoveringLink.value = true;
    activeMenuCategory.value = category;
    
    // Predvolené obrázky pre Závody (Promo Blok)
    if (category === 'zavody' && zavodyData.value[0].items[0]) {
        activePromoImage.value = zavodyData.value[0].items[0].image;
        activePromoName.value = zavodyData.value[0].items[0].name;
        activePromoDesc.value = zavodyData.value[0].items[0].desc;
    }
};

// Zatvorenie celého menu
const closeMenu = () => {
    activeMenuCategory.value = null;
    isHoveringLink.value = false;
};

// Nastavenie aktívnej položky pre Závody
const setHoveredItem = (item) => {
    activePromoImage.value = item.image;
    activePromoName.value = item.name;
    activePromoDesc.value = item.desc;
};

// Event Listenery
onMounted(() => {
    window.addEventListener('scroll', handleScroll);
    window.addEventListener('mousemove', updateMousePosition);
});

onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
    window.removeEventListener('mousemove', updateMousePosition);
});
</script>

<template>
    <!-- Navigačný panel -->
    <nav @mouseleave="closeMenu" 
         :class="[
            'fixed w-full z-50 transition-all duration-500 font-sans', 
            (isScrolled || activeMenuCategory !== null) ? 'bg-[#111827] shadow-2xl py-4' : 'bg-transparent py-6'
         ]">
         
         <div class="max-w-7xl mx-auto px-6 md:px-12 flex justify-between items-center relative z-10">
        <!-- Logo -->
        <a href="#" 
           @mouseenter="isHoveringLink = true" 
           @mouseleave="isHoveringLink = false"
           class="text-2xl font-bold tracking-tighter text-white z-20 relative">
            F1<span class="text-brand text-red-500">AGENCY.</span>
        </a>
        
        <!-- Desktop Menu Položky -->
        <div class="hidden md:flex space-x-10 z-20">
            <a href="#" 
               @mouseenter="openMenu('jazdci')" 
               @mouseleave="isHoveringLink = false"
               :class="['text-sm font-semibold transition-colors relative group py-2', activeMenuCategory === 'jazdci' ? 'text-white' : 'text-gray-200 hover:text-white']">
                Jazdci
                <span :class="['absolute bottom-0 left-0 w-full h-0.5 bg-red-500 transform origin-left transition-transform duration-300', activeMenuCategory === 'jazdci' ? 'scale-x-100' : 'scale-x-0']"></span>
            </a>
            
            <a href="#" 
               @mouseenter="openMenu('konstrukteri')" 
               @mouseleave="isHoveringLink = false"
               :class="['text-sm font-semibold transition-colors relative group py-2', activeMenuCategory === 'konstrukteri' ? 'text-white' : 'text-gray-200 hover:text-white']">
                Konštruktéri
                <span :class="['absolute bottom-0 left-0 w-full h-0.5 bg-red-500 transform origin-left transition-transform duration-300', activeMenuCategory === 'konstrukteri' ? 'scale-x-100' : 'scale-x-0']"></span>
            </a>

            <a href="#" 
               @mouseenter="openMenu('zavody')" 
               @mouseleave="isHoveringLink = false"
               :class="['text-sm font-semibold transition-colors relative group py-2', activeMenuCategory === 'zavody' ? 'text-white' : 'text-gray-200 hover:text-white']">
                Závody
                <span :class="['absolute bottom-0 left-0 w-full h-0.5 bg-red-500 transform origin-left transition-transform duration-300', activeMenuCategory === 'zavody' ? 'scale-x-100' : 'scale-x-0']"></span>
            </a>
            
            <a href="#" 
               @mouseenter="openMenu('historia')" 
               @mouseleave="isHoveringLink = false"
               :class="['text-sm font-semibold transition-colors relative group py-2', activeMenuCategory === 'historia' ? 'text-white' : 'text-gray-200 hover:text-white']">
                História
                <span :class="['absolute bottom-0 left-0 w-full h-0.5 bg-red-500 transform origin-left transition-transform duration-300', activeMenuCategory === 'historia' ? 'scale-x-100' : 'scale-x-0']"></span>
            </a>
        </div>

        <!-- Mobile Menu Button -->
        <button class="md:hidden text-white focus:outline-none z-20">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
            </svg>
        </button>
    </div>

    <!-- DYNAMICKÉ MEGA MENU -->
    <div :class="[
            'absolute top-full left-0 w-full bg-[#111827] border-t border-gray-800 transition-all duration-500 ease-in-out',
            activeMenuCategory !== null ? 'max-h-[85vh] opacity-100 pointer-events-auto shadow-2xl' : 'max-h-0 opacity-0 pointer-events-none overflow-hidden'
         ]">
        
        <div class="max-w-7xl mx-auto px-6 md:px-12 py-10 max-h-[75vh] overflow-y-auto custom-scrollbar">
            
            <!-- 1. KATEGÓRIA: JAZDCI (Grid 22 jazdcov) -->
            <div v-if="activeMenuCategory === 'jazdci'" class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 xl:grid-cols-8 gap-4">
                <div v-for="jazdec in jazdciData" :key="jazdec.name" 
                     @mouseenter="isHoveringLink = true" @mouseleave="isHoveringLink = false"
                     class="flex flex-col items-center bg-[#1f2937] p-4 rounded-xl relative group hover:bg-gray-700 transition-all duration-300 cursor-pointer hover:-translate-y-1">
                    
                    <!-- Dynamický Tag pre Top 3 jazdcov -->
                    <div v-if="jazdec.pos <= 3" :class="[
                        'absolute top-2 right-2 text-[10px] font-bold px-2 py-0.5 rounded shadow-sm uppercase tracking-wider z-10',
                        jazdec.pos === 1 ? 'bg-yellow-400 text-yellow-900' : (jazdec.pos === 2 ? 'bg-gray-300 text-gray-800' : 'bg-amber-600 text-amber-100')
                    ]">
                        {{ jazdec.pos }}{{ jazdec.pos === 1 ? 'st' : (jazdec.pos === 2 ? 'nd' : 'rd') }}
                    </div>

                    <!-- Avatar jazdca (Univerzálny) -->
                    <div class="w-16 h-16 rounded-full bg-gray-800 mb-3 flex items-center justify-center border-2 border-transparent group-hover:border-red-500 transition-colors overflow-hidden">
                        <svg class="w-8 h-8 text-gray-400 group-hover:text-red-400 transition-colors" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2C6.477 2 2 6.477 2 12c0 4.411 2.865 8.166 6.839 9.462v-2.126c-2.457-.962-4.172-3.344-4.172-6.17 0-3.682 2.984-6.666 6.666-6.666 3.682 0 6.667 2.984 6.667 6.666 0 2.826-1.715 5.208-4.172 6.17v2.126C19.135 20.166 22 16.411 22 12c0-5.523-4.477-10-10-10z"/></svg>
                    </div>
                    
                    <span class="text-white font-bold text-xs text-center leading-tight mb-1">{{ jazdec.name }}</span>
                    <span class="text-red-500 font-mono text-[11px] uppercase">{{ jazdec.pts }} pts</span>
                </div>
            </div>

            <!-- 2. KATEGÓRIA: KONŠTRUKTÉRI (Zoznam úloh a operácií s Ikonkami) -->
            <div v-else-if="activeMenuCategory === 'konstrukteri'" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <div v-for="(task, idx) in konstrukteriData" :key="idx" 
                     @mouseenter="isHoveringLink = true" @mouseleave="isHoveringLink = false"
                     class="flex items-start space-x-4 bg-[#1f2937] p-6 rounded-xl hover:bg-gray-700 transition-all duration-300 cursor-pointer group hover:-translate-y-1">
                    
                    <!-- Ikonka z dát -->
                    <div class="w-14 h-14 flex-shrink-0 bg-gray-800 rounded-full flex items-center justify-center text-red-500 group-hover:bg-red-500 group-hover:text-white transition-colors" v-html="task.icon"></div>
                    
                    <div>
                        <h4 class="text-white font-bold text-sm mb-2">{{ task.title }}</h4>
                        <p class="text-gray-400 text-xs leading-relaxed pr-2">{{ task.desc }}</p>
                    </div>
                </div>
            </div>

            <!-- 3. KATEGÓRIA: ZÁVODY -->
            <div v-else-if="activeMenuCategory === 'zavody'" class="grid grid-cols-1 md:grid-cols-5 gap-8 min-h-[320px]">
                <div v-for="(region, idx) in zavodyData" :key="idx" class="col-span-1 border-r border-gray-800 last:border-r-0">
                    <h4 class="text-white font-bold text-lg mb-6">{{ region.title }}</h4>
                    <ul class="space-y-4 pr-6">
                        <li v-for="(race, raceIdx) in region.items" :key="raceIdx">
                            <a href="#" @mouseenter="() => { isHoveringLink = true; setHoveredItem(race); }" @mouseleave="isHoveringLink = false" class="text-gray-400 hover:text-white text-sm font-medium transition-colors flex items-center group">
                                <span class="w-0 h-0.5 bg-red-500 mr-0 group-hover:w-2 group-hover:mr-2 transition-all duration-300"></span>
                                {{ race.name }}
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Promo Blok pre okruhy -->
                <div class="col-span-1 md:col-span-2 bg-[#1f2937] rounded-xl overflow-hidden relative group shadow-inner">
                    <transition name="fade" mode="out-in">
                        <img :key="activePromoImage" :src="activePromoImage" :alt="activePromoName" class="absolute inset-0 w-full h-full object-cover opacity-50 transition-transform duration-700 group-hover:scale-105" />
                    </transition>
                    <div class="relative z-10 flex flex-col justify-end h-full p-8 bg-gradient-to-t from-[#111827] via-transparent to-transparent">
                        <transition name="fade" mode="out-in">
                            <div :key="activePromoName">
                                <h3 class="text-white font-bold text-3xl leading-tight mb-2">{{ activePromoName }}</h3>
                                <p class="text-gray-300 text-sm mb-6">{{ activePromoDesc }}</p>
                            </div>
                        </transition>
                        <button @mouseenter="isHoveringLink = true" @mouseleave="isHoveringLink = false" class="w-max px-6 py-2 bg-red-500 text-white font-bold text-sm rounded hover:bg-red-600 transition-colors shadow-lg">Objavte viac</button>
                    </div>
                </div>
            </div>

            <!-- 4. KATEGÓRIA: HISTÓRIA (Momenty vs Statický obrázok) -->
            <div v-else-if="activeMenuCategory === 'historia'" class="grid grid-cols-1 lg:grid-cols-5 gap-12 min-h-[350px]">
                
                <!-- Zoznam historických míľnikov -->
                <div class="col-span-1 lg:col-span-3 flex flex-col justify-center">
                    <h3 class="text-white font-bold text-xl mb-8 uppercase tracking-widest border-b border-gray-800 pb-4">Míľniky Kráľovnej Motošportu</h3>
                    <div class="space-y-4">
                        <div v-for="(moment, idx) in historiaData.moments" :key="idx" 
                             @mouseenter="isHoveringLink = true" @mouseleave="isHoveringLink = false"
                             class="flex items-center space-x-6 group cursor-pointer p-2 rounded hover:bg-gray-800/50 transition-colors">
                            <span class="text-red-500 font-mono font-bold text-lg w-16 text-right">{{ moment.year }}</span>
                            <span class="text-gray-400 font-medium text-sm group-hover:text-white transition-colors">{{ moment.title }}</span>
                        </div>
                    </div>
                </div>

                <!-- Veľký Vintage Obrázok -->
                <div class="col-span-1 lg:col-span-2 bg-black rounded-xl overflow-hidden relative group shadow-lg cursor-pointer h-full min-h-[300px]" @mouseenter="isHoveringLink = true" @mouseleave="isHoveringLink = false">
                    <img :src="historiaData.image" alt="Historia F1" class="absolute inset-0 w-full h-full object-cover opacity-70 group-hover:scale-105 transition-transform duration-1000 grayscale group-hover:grayscale-0" />
                    <!-- Dekoratívny odznak / text -->
                    <div class="absolute bottom-6 left-6 z-10">
                        <h3 class="text-white font-bold text-3xl tracking-wider uppercase drop-shadow-lg">Odkaz<br/><span class="text-red-500">Legiend</span></h3>
                    </div>
                </div>
            </div>

        </div>
    </div>
</nav>

<!-- ŠPECIÁLNY KURZOR (Ružovo-červený kruh) -->
<div class="hidden md:block fixed top-0 left-0 pointer-events-none z-[100] transition-all duration-200 ease-out mix-blend-screen"
     :style="{
        transform: `translate(${mouseX}px, ${mouseY}px) translate(-50%, -50%)`,
        width: isHoveringLink ? '80px' : '40px',
        height: isHoveringLink ? '80px' : '40px',
        opacity: mouseX > 0 ? 1 : 0
     }">
    <div :class="[
        'w-full h-full rounded-full bg-red-500 opacity-50 blur-[2px] transition-transform duration-300',
        isHoveringLink ? 'scale-100' : 'scale-50'
    ]"></div>
</div>

</template>

<style scoped>
/* CSS Animácie pre plynulé menenie obrázkov a textu v Závodoch */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.4s ease-in-out;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* Úprava scrollovania, ak by bol zoznam dlhší */
.custom-scrollbar::-webkit-scrollbar {
    width: 6px;
}
.custom-scrollbar::-webkit-scrollbar-track {
    background: #111827; 
}
.custom-scrollbar::-webkit-scrollbar-thumb {
    background: #374151; 
    border-radius: 4px;
}
.custom-scrollbar::-webkit-scrollbar-thumb:hover {
    background: #ef4444; 
}
</style>