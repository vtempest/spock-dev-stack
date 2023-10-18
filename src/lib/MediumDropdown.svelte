<script lang="ts">
	export let label: string;
</script>

<div class="bg-[#2E2E2E] rounded-md drop-shadow-md absolute w-72 left-full -translate-x-72 p-4">
	<div class="flex justify-between mb-4 mx-2">
		<h4 class="text-lg font-semibold">{label}</h4>
		<img src="/dots.svg" alt="dot dot dot" class="w-4" />
	</div>
	<slot />
</div>
