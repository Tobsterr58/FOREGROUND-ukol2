<script setup>
</script>

<template>
    <!-- Sekcia zaberá min. 80vh, biele pozadie pre čistý agentúrny vzhľad -->
    <section class="max-h-[80vh] min-h-[70vh] bg-white flex items-center py-24 md:py-32">
        <div class="max-w-7xl mx-auto px-6 md:px-12 w-full">
            
            <!-- Hlavný úvodný text inšpirovaný predlohou, prispôsobený pre F1 -->
            <div class="mb-20 md:mb-32">
                <p class="text-2xl md:text-3xl lg:text-[1.5rem] text-gray-600 font-light leading-snug md:leading-relaxed max-w-6xl" data-aos="fade-up" data-aos-duration="1000">
                    Vitajte! Špecializujeme sa na pretekárske systémy, pokročilú aerodynamiku a analýzu dát. 
                    Našou supermocou je neúnavná snaha hľadať stotiny sekundy, či už v dizajne alebo priamo na trati. 
                    Najplodnejšie víkendy sú tie, kedy z paddocku odchádzame s novými poznatkami. 
                    Sme zvedavý, vášnivý a odhodlaný inžiniersky tím, pripravený riešiť tie najkomplexnejšie výzvy motoršportu.
                </p>
            </div>

            <!-- Mriežka s 3 kategóriami -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-12 lg:gap-20">
                
                <!-- Kategória 1 -->
                <div data-aos="fade-up" data-aos-duration="1000" data-aos-delay="100">
                    <!-- Farba #d81b60 sa blíži k tej z obrázka (magenta/pink-red) -->
                    <h3 class="text-xl md:text-2xl font-bold text-[#d81b60] mb-4 tracking-tight">
                        01. Stratégia
                    </h3>
                    <p class="text-gray-500 font-light leading-relaxed text-base md:text-lg">
                        Premýšľame na pomedzí presných dát a inštinktu, aby sme vytvorili silné a trvácne rozhodnutia, 
                        ktoré maximalizujú výkon a vyhrávajú preteky.
                    </p>
                </div>

                <!-- Kategória 2 -->
                <div data-aos="fade-up" data-aos-duration="1000" data-aos-delay="200">
                    <h3 class="text-xl md:text-2xl font-bold text-[#d81b60] mb-4 tracking-tight">
                        02. Aerodynamika
                    </h3>
                    <p class="text-gray-500 font-light leading-relaxed text-base md:text-lg">
                        Pracujeme na bode, kde sa stretáva estetika s čistou funkčnosťou. Formujeme vzduch 
                        a prítlak tak, aby pracoval v náš absolútny prospech.
                    </p>
                </div>

                <!-- Kategória 3 -->
                <div data-aos="fade-up" data-aos-duration="1000" data-aos-delay="300">
                    <h3 class="text-xl md:text-2xl font-bold text-[#d81b60] mb-4 tracking-tight">
                        03. Inžinierstvo
                    </h3>
                    <p class="text-gray-500 font-light leading-relaxed text-base md:text-lg">
                        Spájame špičkové technológie a udržateľnosť pre vytvorenie zmysluplných 
                        inovácií, ktoré definujú dizajn a budúcnosť monopostov.
                    </p>
                </div>

            </div>

        </div>
    </section>
</template>