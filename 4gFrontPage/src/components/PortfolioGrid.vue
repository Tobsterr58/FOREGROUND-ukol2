<script setup>
import { ref } from 'vue';

// Čisté URL adresy priamo do poľa stringov
const projects = ref([
    { title: 'Minimalist Workspace', category: 'Branding', image: 'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=800&q=80' },
    { title: 'Neon Campaign', category: 'Marketing', image: 'https://images.unsplash.com/photo-1557672172-298e090bd0f1?auto=format&fit=crop&w=800&q=80' },
    { title: 'E-commerce App', category: 'Web Design', image: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=800&q=80' },
    { title: 'Architecture Web', category: 'Development', image: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=800&q=80' },
    { title: 'Abstract 3D', category: 'Motion Design', image: 'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?auto=format&fit=crop&w=800&q=80' },
    { title: 'Mobile UI Kit', category: 'UI/UX', image: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?auto=format&fit=crop&w=800&q=80' }
]);
</script>

<template>
    <section id="portfolio" class="bg-gray-100">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-1">
            <div v-for="(project, index) in projects" :key="index" 
                 class="relative group overflow-hidden h-80 md:h-96 cursor-pointer bg-brand-900" 
                 data-aos="fade-in" :data-aos-delay="index * 100">
                
                <img :src="project.image" :alt="project.title" 
                     class="w-full h-full object-cover transition-transform duration-700 ease-in-out group-hover:scale-110 opacity-90 group-hover:opacity-40" />
                
                <div class="absolute inset-0 flex flex-col items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
                    <span class="text-brand-50 text-sm font-semibold tracking-wider uppercase mb-2 transform translate-y-4 group-hover:translate-y-0 transition-transform duration-300">{{ project.category }}</span>
                    <h3 class="text-white text-2xl font-bold text-center px-4 transform translate-y-4 group-hover:translate-y-0 transition-transform duration-300 delay-75">{{ project.title }}</h3>
                </div>
            </div>
        </div>
    </section>
</template>