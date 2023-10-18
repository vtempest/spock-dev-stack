<script lang="ts">
	type IconOptions = 'gear' | 'help' | 'sign-out';

	export let icon: IconOptions;
	export let label: string;
	export let onClick : ()=>void;
	export let showArrow = false;
</script>

<button class="hover:bg-neutral-600 p-2 rounded-md flex items-center justify-between w-full" on:click={onClick}>
	<div class="flex items-center">
		<div class="w-8 h-8 rounded-full bg-neutral-600 mr-3 flex justify-center items-center">
            <img src="/{icon}.svg" alt="Supporting Icon" class="w-5"/>
        </div>
		<p class="font-semibold text-neutral-200">{label}</p>
	</div>
	{#if showArrow}
		<img src="/chevron-right.svg" alt="Right Arrow" class="h-4" />
	{/if}
</button>
