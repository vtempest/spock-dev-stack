<script lang="ts">
	export let name:string;
    export let avatar:any;
    export let onClick: () => void;
    export let onFollow: () => void;
</script>

<div
class="flex justify-between mb-2 items-center hover:bg-neutral-700 p-2 rounded-md hover:cursor-pointer"
>
<button class="flex items-center space-x-2" on:click={onClick}>
    <img src={avatar} alt="profile Icon" class="w-8 h-8 object-cover rounded-full bg-white" />
    <p>{name}</p>
</button>
<button on:click={onFollow}>
    <p class="font-semibold text-[#378E8B] hover:underline hover:cursor-pointer">Follow</p>
</button>
</div>