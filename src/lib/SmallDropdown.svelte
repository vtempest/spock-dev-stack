<script lang="ts">
	export let showDelete: boolean = false;
	export let onDelete: () => void;
</script>

<div class="bg-[#373737] rounded-md drop-shadow-md absolute w-64 right-6 top-14 p-2 z-20">
	{#if showDelete}
		<button on:click={onDelete} class="flex items-center hover:bg-neutral-600 p-2 rounded-md w-full">
			<img src="/trash-can-red.svg" alt="dot dot dot" class="w-4 mr-3" />
			<div class="text-left">
				<h4 class=" text-red-400 text-sm font-semibold">Delete Post</h4>
			</div>
		</button>
	{/if}
	<button class="flex items-center hover:bg-neutral-600 p-2 rounded-md w-full">
		<img src="/report.svg" alt="dot dot dot" class="w-4 mr-3" />
		<div class="text-left">
			<h4 class="text-white text-sm font-semibold">Report Post</h4>
			<p class="text-neutral-500 text-xs">This post violates content policy</p>
		</div>
	</button>
	<slot />
</div>
