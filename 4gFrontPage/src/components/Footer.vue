<template>
    <footer class="bg-[#111827] text-white">

        <!-- Oddelovač -->
        <div class="border-t border-gray-800 mx-6 md:mx-12"></div>

        <!-- 4 stĺpce -->
        <div class="max-w-7xl mx-auto px-6 md:px-12 py-16 grid grid-cols-2 md:grid-cols-4 gap-10">

            <div>
                <p class="text-sm font-semibold text-white mb-5">Sleduj F1</p>
                <div class="flex items-center gap-4">
                    <a href="https://www.facebook.com/Formula1" target="_blank" rel="noopener" aria-label="Facebook"
                       class="text-gray-400 hover:text-white transition-colors">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z"/>
                        </svg>
                    </a>
                    <a href="https://www.youtube.com/@Formula1" target="_blank" rel="noopener" aria-label="YouTube"
                       class="text-gray-400 hover:text-white transition-colors">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M22.54 6.42a2.78 2.78 0 00-1.95-1.96C18.88 4 12 4 12 4s-6.88 0-8.59.46A2.78 2.78 0 001.46 6.42 29 29 0 001 12a29 29 0 00.46 5.58 2.78 2.78 0 001.95 1.96C5.12 20 12 20 12 20s6.88 0 8.59-.46a2.78 2.78 0 001.95-1.96A29 29 0 0023 12a29 29 0 00-.46-5.58zM9.75 15.02V8.98L15.5 12l-5.75 3.02z"/>
                        </svg>
                    </a>
                    <a href="https://twitter.com/F1" target="_blank" rel="noopener" aria-label="X / Twitter"
                       class="text-gray-400 hover:text-white transition-colors">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
                        </svg>
                    </a>
                    <a href="https://www.instagram.com/f1" target="_blank" rel="noopener" aria-label="Instagram"
                       class="text-gray-400 hover:text-white transition-colors">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                            <rect x="2" y="2" width="20" height="20" rx="5" ry="5" fill="none" stroke="currentColor" stroke-width="2"/>
                            <circle cx="12" cy="12" r="4" fill="none" stroke="currentColor" stroke-width="2"/>
                            <circle cx="17.5" cy="6.5" r="1" fill="currentColor" stroke="none"/>
                        </svg>
                    </a>
                </div>
            </div>

            <div>
                <p class="text-sm font-semibold text-white mb-5">Navigácia</p>
                <ul class="space-y-3">
                    <li><a href="#" class="text-gray-400 hover:text-white transition-colors text-sm">Výsledky</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition-colors text-sm">Jazdci</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition-colors text-sm">Tímy</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition-colors text-sm">Kalendár</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition-colors text-sm">Pirelli stratégia</a></li>
                </ul>
            </div>

            <div>
                <p class="text-sm font-semibold text-white mb-5">Sezóna 2025</p>
                <p class="text-gray-400 text-sm leading-relaxed mb-1">Formula 1 World Championship</p>
                <p class="text-gray-400 text-sm leading-relaxed mb-1">24 Veľkých cien</p>
                <p class="text-gray-400 text-sm leading-relaxed mb-4">20 Jazdcov · 10 Tímov</p>
                <a href="https://www.formula1.com" target="_blank" rel="noopener"
                   class="text-[#e83e8c] hover:text-white transition-colors text-sm">
                    formula1.com →
                </a>
            </div>

            <div>
                <p class="text-sm font-semibold text-white mb-5">Projekt</p>
                <p class="text-gray-400 text-sm leading-relaxed mb-1">hello@yourwebsite.com</p>
                <p class="text-gray-400 text-sm leading-relaxed mb-4">Vytvorené s vášňou a Vue 3<br>by Tobiáš Štec</p>
                <a href="#" class="text-[#e83e8c] hover:text-white transition-colors text-sm">
                    F1<span class="font-bold">AGENCY.</span>
                </a>
            </div>

        </div>

    </footer>
</template>