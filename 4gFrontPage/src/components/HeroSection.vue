<template>
    <section id="home" class="relative h-screen flex items-center justify-center overflow-hidden">
        <div class="absolute inset-0 z-0">
            <!-- Čistá URL adresa pre Vite -->
            <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=1920&q=80" alt="Agency Office" class="w-full h-full object-cover" />
            <div class="absolute inset-0 bg-brand-900/70"></div>
        </div>
        
        <div class="relative z-10 text-center px-4 max-w-4xl mx-auto" data-aos="fade-up" data-aos-duration="1000">
            <h1 class="text-5xl md:text-7xl font-bold text-white mb-6 leading-tight">
                Vytvárame výnimočné <br><span class="text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-brand">digitálne zážitky</span>
            </h1>
            <p class="text-lg md:text-xl text-gray-300 mb-10 max-w-2xl mx-auto">
                Sme moderná kreatívna agentúra zameraná na inovatívny dizajn, špičkové technológie a rast vášho biznisu.
            </p>
            <a href="#portfolio" class="inline-block bg-brand hover:bg-blue-700 text-white font-semibold py-4 px-8 rounded-full transition-all transform hover:-translate-y-1 hover:shadow-lg">
                Pozrieť naše práce
            </a>
        </div>
    </section>
</template>