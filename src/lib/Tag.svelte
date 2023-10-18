<script lang="ts">
	export let label: string;
    //export let colorId:number = 0;
    export let onClick:()=>void = () => {};
</script>

<button class="text-xs text-neutral-300 bg-emerald-600 rounded-full py-1 text-left px-4 font-semibold hover:cursor-pointer hover:text-white" on:click={onClick}>
	#{label}
</button>
