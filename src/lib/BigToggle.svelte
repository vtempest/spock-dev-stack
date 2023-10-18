<script lang="ts">
    export let toggleChanged: (state:boolean) => void = ()=>{};

	let toggledRight: boolean = false;

    function toggleMenu(right: boolean){
        toggledRight = right;
        toggleChanged(right);
    }
</script>

<div
	class="bg-[#2E2E2E] 2xl:w-[600px] w-[500px] rounded-md drop-shadow-md text-neutral-300 border-b-[1px] border-neutral-600 flex items-center"
>
	<button
		class={toggledRight
			? 'flex-1 flex justify-center items-center space-x-2 p-3 hover:bg-neutral-700 rounded-md m-2'
			: 'flex-1 flex justify-center items-center space-x-2 border-b-2 border-[#378E8B] p-5'}
		on:click={() => toggleMenu(false)}
	>
		{#if toggledRight}
			<img src="/globe.svg" alt="Globe" class="w-5" />
		{:else}
			<img src="/globe-color.svg" alt="Globe" class="w-5" />
		{/if}
		<h3 class={toggledRight ? 'font-semibold' : 'font-semibold text-[#378E8B]'}>Global</h3>
	</button>
	<button
		class={!toggledRight
			? 'flex-1 flex justify-center items-center space-x-2 p-3 hover:bg-neutral-700 rounded-md m-2'
			: 'flex-1 flex justify-center items-center space-x-2 border-b-2 border-[#378E8B] p-5'}
		on:click={() => toggleMenu(true)}
	>
		{#if !toggledRight}
			<img src="/friends.svg" alt="Group of people" class="w-6" />
		{:else}
			<img src="/friends-color.svg" alt="Group of people" class="w-6" />
		{/if}
		<h3 class={!toggledRight ? 'font-semibold' : 'font-semibold text-[#378E8B]'}>Following</h3>
	</button>
</div>
