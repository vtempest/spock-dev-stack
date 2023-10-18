<script lang="ts">
    type IconOptions = "bell" | "message"; 

	export let icon:IconOptions;
    export let notifications: number = 0;
    export let onClick: () => void;

</script>

<button class="relative h-10 w-10 bg-neutral-600 rounded-full flex justify-center items-center hover:bg-neutral-500" on:click={onClick}>
    {#if notifications}
    <div class="absolute w-5 h-5 -top-1 -right-2 bg-red-600 text-xs font-semibold rounded-full drop-shadow-sm flex justify-center items-center">
        <p>{notifications}</p>
    </div>
    {/if}
    <img src="/{icon}.svg" alt="Bell" class="w-4"/>
</button>
