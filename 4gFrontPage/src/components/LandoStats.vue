<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

// Cieľové hodnoty pre Landa Norrisa
const targetWins = 7;
const targetPodiums = 19;
const targetPoles = 7;
const targetPoints = 420;

// Aktuálne (animované) hodnoty, ktoré sa zobrazujú v šablóne
const currentWins = ref(0);
const currentPodiums = ref(0);
const currentPoles = ref(0);
const currentPoints = ref(0);

// Referencia na hlavný obal sekcie pre sledovanie scrollovania
const sectionRef = ref(null);
let hasAnimated = false; // Zabezpečí, že animácia prebehne len raz

// Funkcia pre plynulú animáciu čísel
const animateValue = (target, currentRef, duration) => {
    let startTimestamp = null;
    const step = (timestamp) => {
        if (!startTimestamp) startTimestamp = timestamp;
        const progress = Math.min((timestamp - startTimestamp) / duration, 1);
        
        // Vypočíta aktuálnu hodnotu na základe progresu
        currentRef.value = Math.floor(progress * target);
        
        if (progress < 1) {
            window.requestAnimationFrame(step);
        } else {
            currentRef.value = target; // Poistka pre presný výsledok
        }
    };
    window.requestAnimationFrame(step);
};

// Spustenie všetkých animácií s rôznou dĺžkou trvania
const startAnimation = () => {
    if (hasAnimated) return;
    hasAnimated = true;
    animateValue(targetWins, currentWins, 2500); // Výhry za 1.5s
    animateValue(targetPodiums, currentPodiums, 3000); // Pódiá za 2s
    animateValue(targetPoles, currentPoles, 2800); // Poles za 1.8s
    animateValue(targetPoints, currentPoints, 3500); // Body za 2.5s (najväčšie číslo)
};

let observer;

onMounted(() => {
    // IntersectionObserver sleduje, kedy sa element objaví na obrazovke
    observer = new IntersectionObserver((entries) => {
        if (entries[0].isIntersecting) {
            startAnimation();
        }
    }, { threshold: 0.3 }); // Spustí sa, keď je vidieť aspoň 30% sekcie

    if (sectionRef.value) {
        observer.observe(sectionRef.value);
    }
});

onUnmounted(() => {
    // Vyčistenie observera pri zničení komponentu
    if (observer && sectionRef.value) {
        observer.unobserve(sectionRef.value);
    }
});
</script>

<template>
    <!-- Hlavný obal zaberajúci 80vh s tmavým pozadím -->
    <section ref="sectionRef" class="w-full bg-[#111827] min-h-[80vh] flex items-center justify-center relative overflow-hidden py-24">
        
        <div class="max-w-7xl mx-auto w-full px-6 md:px-12 relative z-10">
            
            <!-- Vrchná časť: Veľký nadpis a citát -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-12 md:gap-24 mb-16 items-center">
                
                <!-- Ľavá strana: Nadpis -->
                <div>
                    <h2 class="text-white text-5xl md:text-6xl lg:text-7xl font-bold tracking-tight leading-tight">
                        Lando Norris<br>
                        <span class="text-transparent bg-clip-text bg-gradient-to-r from-orange-400 to-red-500">
                            Líder šampionátu
                        </span>
                    </h2>
                </div>
                
                <!-- Pravá strana: Citát / Popis -->
                <div class="md:pl-8 border-l-0 md:border-l border-gray-800">
                    <p class="text-gray-300 text-lg md:text-xl leading-relaxed font-light">
                        "Pretekáme s vášňou a precíznosťou. Každý bod, každá stotina sekundy sa počíta. 
                        Táto sezóna ukazuje silu tímu McLaren a naše neúnavné odhodlanie byť na vrchole 
                        kráľovnej motoršportu."
                    </p>
                </div>
                
            </div>

            <!-- Oddelovač (tenká čiara) -->
            <div class="w-full h-px bg-gray-800 mb-16"></div>

            <!-- Spodná časť: Štatistiky -->
            <div class="grid grid-cols-2 md:grid-cols-4 gap-8">
                
                <!-- Štatistika 1: Výhry -->
                <div class="flex flex-col">
                    <span class="text-4xl md:text-5xl lg:text-6xl font-bold text-[#e83e8c] mb-2 font-mono tabular-nums">
                        {{ currentWins }}
                    </span>
                    <span class="text-white font-semibold text-lg md:text-xl tracking-wide">Výhry</span>
                </div>

                <!-- Štatistika 2: Pódiá -->
                <div class="flex flex-col">
                    <span class="text-4xl md:text-5xl lg:text-6xl font-bold text-[#e83e8c] mb-2 font-mono tabular-nums">
                        {{ currentPodiums }}
                    </span>
                    <span class="text-white font-semibold text-lg md:text-xl tracking-wide">Pódiá</span>
                </div>

                <!-- Štatistika 3: Pole Positions -->
                <div class="flex flex-col">
                    <span class="text-4xl md:text-5xl lg:text-6xl font-bold text-[#e83e8c] mb-2 font-mono tabular-nums">
                        {{ currentPoles }}
                    </span>
                    <span class="text-white font-semibold text-lg md:text-xl tracking-wide">Pole Positions</span>
                </div>

                <!-- Štatistika 4: Body (420) -->
                <div class="flex flex-col">
                    <span class="text-4xl md:text-5xl lg:text-6xl font-bold text-[#e83e8c] mb-2 font-mono tabular-nums">
                        {{ currentPoints }}<span class="text-2xl md:text-3xl lg:text-4xl align-top ml-1">pts</span>
                    </span>
                    <span class="text-white font-semibold text-lg md:text-xl tracking-wide">Celkové Body</span>
                </div>

            </div>

        </div>
    </section>
</template>